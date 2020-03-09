Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9233217E023
	for <lists+linux-arch@lfdr.de>; Mon,  9 Mar 2020 13:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgCIMYg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Mar 2020 08:24:36 -0400
Received: from foss.arm.com ([217.140.110.172]:51506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgCIMYg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Mar 2020 08:24:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1B7F30E;
        Mon,  9 Mar 2020 05:24:34 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20D953F6CF;
        Mon,  9 Mar 2020 05:24:32 -0700 (PDT)
Date:   Mon, 9 Mar 2020 12:24:30 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com,
        x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 00/20] Introduce common headers
Message-ID: <20200309122429.GB26309@lakrids.cambridge.arm.com>
References: <20200306133242.26279-1-vincenzo.frascino@arm.com>
 <3278D604-28F1-47A1-BAB8-D8EB439995E8@amacapital.net>
 <b18c7ce1-0948-a9e2-2d7e-d019669a71e1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b18c7ce1-0948-a9e2-2d7e-d019669a71e1@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 09, 2020 at 11:07:08AM +0000, Vincenzo Frascino wrote:
> Hi Andy,
> 
> On 3/6/20 4:04 PM, Andy Lutomirski wrote:
> 
> [...]
> 
> >>
> >> To solve the problem, I decided to use the approach below:
> >>  * Extract from include/linux/ the vDSO required kernel interface
> >>    and place it in include/common/
> > 
> > I really like the approach, but I’m wondering if “common” is the
> > right name. This directory is headers that aren’t stable ABI like
> > uapi but are shared between the kernel and the vDSO. Regular user
> > code should *not* include these, right?
> > 
> > Would “vdso” or perhaps “private-abi” be clearer?
> 
> Thanks! These headers are definitely not "uapi" like and they are meant to
> evolve in future like any other kernel header. We have just to make sure that
> the evolution does not break what we are trying to achieve with this series.

Given we already include uapi/* headers in kernel code, I think placing
these in a vdso/* namespace would be fine. I think that more clearly
expresses the constraints on the headers than private-abi/* would.

Thanks,
Mark.
