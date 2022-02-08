Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E104AD491
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 10:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353517AbiBHJR0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Feb 2022 04:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350674AbiBHJRW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Feb 2022 04:17:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA2FC03FEDA;
        Tue,  8 Feb 2022 01:17:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EF1E61479;
        Tue,  8 Feb 2022 09:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D140C340ED;
        Tue,  8 Feb 2022 09:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644311838;
        bh=BRQppVmJemnXXpfZXfcxyJ76Uix+mNSFNn+dOUBit+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3EKAJXrMGa7sLQ/UIGqVwvEhckiwK7KbAYqdpGASMWBfI35qyTU08kJM7VInr/u7
         L3HW1aG+k1r2XrAoYTgGpNICjfxqai3FcsJnTbxo86tYp1wj+Lde7V60xIX006sEyW
         w09Bzpsf6vUTpugq2l6spY1jKstIAX00/fA4FVKSIgpKT8VVKnfmsCzaZnWrOOkBuZ
         ZDGUROkTnlT3AX2stNNHZlSY1kqNoYYReLMvuXDSyWKrcWommrFseWqRFSjPujgbYj
         mceqt8Wcr0mdJ9QEWbQ+WTEH7UJPk61Et2a1RF9hTSjIIBGoS0jwmY4WoekJXtIegp
         mM1Lptsk/sLWA==
Date:   Tue, 8 Feb 2022 11:16:51 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Adrian Reber <adrian@lisas.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Message-ID: <YgI1A0CtfmT7GMIp@kernel.org>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <YgAWVSGQg8FPCeba@kernel.org>
 <YgDIIpCm3UITk896@lisas.de>
 <8f96c2a6-9c03-f97a-df52-73ffc1d87957@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f96c2a6-9c03-f97a-df52-73ffc1d87957@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 07, 2022 at 08:30:50AM -0800, Dave Hansen wrote:
> On 2/6/22 23:20, Adrian Reber wrote:
> >>> 	CRIU Support
> >>> 	------------
> >>> 	In the past there was some speculation on the mailing list about 
> >>> 	whether CRIU would need to be taught about CET. It turns out, it does. 
> >>> 	The first issue hit is that CRIU calls sigreturn directly from its 
> >>> 	“parasite code” that it injects into the dumper process. This violates
> >>> 	this shadow stack implementation’s protection that intends to prevent
> >>> 	attackers from doing this.
> ...
> >>From the CRIU side I can say that I would definitely like to see this
> > resolved. CRIU just went through a similar exercise with rseq() being
> > enabled in glibc and CI broke all around for us and other projects
> > relying on CRIU. Although rseq() was around for a long time we were not
> > aware of it but luckily 5.13 introduced a way to handle it for CRIU with
> > ptrace. An environment variable existed but did not really help when
> > CRIU is called somewhere in the middle of the container software stack.
> > 
> >>From my point of view a solution not involving an environment variable
> > would definitely be preferred.
> 
> Have there been things like this for CRIU in the past?  Something where
> CRIU needs control but that's also security-sensitive?

Generally CRIU requires (almost) root privileges to work, but I don't think
it handles something as security sensitive and restrictive as shadow stacks. 
 
> Any thoughts on how you would _like_ to see this resolved?

Ideally, CRIU will need a knob that will tell the kernel/CET machinery
where the next RET will jump, along the lines of
restore_signal_shadow_stack() AFAIU.

But such a knob will immediately reduce the security value of the entire
thing, and I don't have good ideas how to deal with it :(

-- 
Sincerely yours,
Mike.
