Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20673D3733
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 03:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfJKBj3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 21:39:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40955 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbfJKBj3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Oct 2019 21:39:29 -0400
Received: from [IPv6:2601:646:8600:3281:14ec:615e:cb9c:4171] ([IPv6:2601:646:8600:3281:14ec:615e:cb9c:4171])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x9B1cDnV301404
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 10 Oct 2019 18:38:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x9B1cDnV301404
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1570757896;
        bh=TUIhoFcV+31eZTr1kONofaEMms3/RhBG/iU3TdNS+pY=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=oW9dfaaRmKd2dWoG3cgkzVO7BvegyKalCQTxvCkvgSHMMP1aHzoAgAKgrdfUT1oLy
         knMJjvPLF83nLOn/ZAN3CPvsjjRfkJ0aerhHPcT19nudWK5NOitM033cLOnaGvI2e1
         LSFP3+8NCXofkKyTku2Ig+hd5GPCzdOhgJdURHIZGaQ2FvCQboeNg++CFWqgbXefQR
         /SpG4FYMCfGdB5IJbLA+2mNkqs5PSktOsAiaYQAYgeDgNBG+PkAvJWstHjn+LuCQM9
         xfo1Giy+1NXKFUnN4iD3tpGhUd+JWd6VRGxDGhkAiURF0SGwTc0cH1h/qmMomAnUUS
         wkKqLjoRiDOug==
Date:   Thu, 10 Oct 2019 18:38:03 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <201910101657.234CB71E53@keescook>
References: <20190926175602.33098-1-keescook@chromium.org> <20191010180331.GI7658@zn.tnic> <201910101657.234CB71E53@keescook>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/29] vmlinux.lds.h: Refactor EXCEPTION_TABLE and NOTES
To:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
From:   hpa@zytor.com
Message-ID: <A020A6D1-C7DB-480B-826E-AE18308CD3E5@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On October 10, 2019 4:57:36 PM PDT, Kees Cook <keescook@chromium=2Eorg> wro=
te:
>On Thu, Oct 10, 2019 at 08:03:31PM +0200, Borislav Petkov wrote:
>> On Thu, Sep 26, 2019 at 10:55:33AM -0700, Kees Cook wrote:
>> > This series works to move the linker sections for NOTES and
>> > EXCEPTION_TABLE into the RO_DATA area, where they belong on most
>> > (all?) architectures=2E The problem being addressed was the discovery
>> > by Rick Edgecombe that the exception table was accidentally marked
>> > executable while he was developing his execute-only-memory series=2E
>When
>> > permissions were flipped from readable-and-executable to
>only-executable,
>> > the exception table became unreadable, causing things to explode
>rather
>> > badly=2E :)
>> >=20
>> > Roughly speaking, the steps are:
>> >=20
>> > - regularize the linker names for PT_NOTE and PT_LOAD program
>headers
>> >   (to "note" and "text" respectively)
>> > - regularize restoration of linker section to program header
>assignment
>> >   (when PT_NOTE exists)
>> > - move NOTES into RO_DATA
>> > - finish macro naming conversions for RO_DATA and RW_DATA
>> > - move EXCEPTION_TABLE into RO_DATA on architectures where this is
>clear
>> > - clean up some x86-specific reporting of kernel memory resources
>> > - switch x86 linker fill byte from x90 (NOP) to 0xcc (INT3), just
>because
>> >   I finally realized what that trailing ": 0x9090" meant -- and we
>should
>> >   trap, not slide, if execution lands in section padding
>>=20
>> Yap, nice patchset overall=2E
>
>Thanks!
>
>> > Since these changes are treewide, I'd love to get
>architecture-maintainer
>> > Acks and either have this live in x86 -tip or in my own tree,
>however
>> > people think it should go=2E
>>=20
>> Sure, I don't mind taking v2 through tip once I get ACKs from the
>> respective arch maintainers=2E
>
>Okay, excellent=2E I've only had acks from arm64, but I'll call it out
>again in v2=2E Thanks for the review!

I would like to once again advocate for the generalized link table mechani=
sm=2E It is nuts that each individual table should need vmlinux=2Elds hacki=
ng across architectures=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
