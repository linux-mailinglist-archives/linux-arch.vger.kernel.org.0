Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFC9818E0F4
	for <lists+linux-arch@lfdr.de>; Sat, 21 Mar 2020 13:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgCUMGn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Mar 2020 08:06:43 -0400
Received: from foss.arm.com ([217.140.110.172]:34740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgCUMGm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 21 Mar 2020 08:06:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 134EC31B;
        Sat, 21 Mar 2020 05:06:42 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 026A33F52E;
        Sat, 21 Mar 2020 05:06:38 -0700 (PDT)
Date:   Sat, 21 Mar 2020 12:06:36 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, x86@kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [PATCH v5 18/26] arm64: vdso32: Code clean up
Message-ID: <20200321120635.GA3052@mbp>
References: <20200320145351.32292-1-vincenzo.frascino@arm.com>
 <20200320145351.32292-19-vincenzo.frascino@arm.com>
 <158474646622.125146.3263940499372231797@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158474646622.125146.3263940499372231797@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 20, 2020 at 04:21:06PM -0700, Stephen Boyd wrote:
> Quoting Vincenzo Frascino (2020-03-20 07:53:43)
> > The compat vdso library had some checks that are not anymore relevant.
> 
> Can we get the information on why they aren't relevant anymore in the
> commit text? I'd rather not find this commit three years from now and
> have no idea why it was applied.

Good point. But I'd rather say that the original reason for adding them
was bogus (ABI compatibility between arm64 compat and arm32, when arm32
vdso never got them).

There may be some (very hard to justify) reason to add them if we want
compatibility between vdso and syscall fallback on addresses greater
than TASK_SIZE. The vdso code generates a SIGSEGV or SIGBUS while the
syscall returns -EFAULT. However, you'd have similar mismatch on
unmapped addresses below TASK_SIZE which cannot be handled by the vdso
(not a simple comparison).

I think the vdsotest code should be adjusted accordingly.

-- 
Catalin
