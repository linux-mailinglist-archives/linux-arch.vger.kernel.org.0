Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF4E48DFD9
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jan 2022 22:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbiAMVrg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jan 2022 16:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbiAMVrf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jan 2022 16:47:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C14C061574;
        Thu, 13 Jan 2022 13:47:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BA6F6124E;
        Thu, 13 Jan 2022 21:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3D4C36AE3;
        Thu, 13 Jan 2022 21:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642110453;
        bh=mhvc/TtRX/W/HwVS0Gz9WmgUd95cMfFsAeoEdm3+0Wk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BAHULMDLmD4Nx4jsI5NkR4AD2iFGCDjTfWig0XgJI7/nWbgANiqssXhckQ+23Dpu/
         Zp/U9LxjrukdI9+Ng4SkQYMC2Jx2VKBAWIq0U3a+AKHUoSDYU7tDFqU7XWv/mUXg0g
         KYeCXjPDKWkYdR8StFj/t6OeCxh1Lsr7ccp2woIzJ00SQ1dpzqMgfVCIYnhnbFLlYz
         w+joMc5+scnyKTZOl2MRFZ2QFt3J6MjP1DldHs8+Xzu3I719TUjectap2k1MchtZHs
         XWVJV36e6o8v9nhOKbHDw4NK/OE4TuqtB4KezT+m/gn3jlB2j2xGlx6mo+TCIfFYUK
         UmrM3oRqgQLAw==
Message-ID: <e431fa42-26ec-8ac6-f954-e681b1e0e9a6@kernel.org>
Date:   Thu, 13 Jan 2022 13:47:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 1/3] x86: Implement arch_prctl(ARCH_VSYSCALL_CONTROL)
 to disable vsyscall
Content-Language: en-US
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-arch@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        linux-x86_64@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, the arch/x86 maintainers <x86@kernel.org>,
        musl@lists.openwall.com, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Andrei Vagin <avagin@gmail.com>
References: <3a1c8280967b491bf6917a18fbff6c9b52e8df24.1641398395.git.fweimer@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <3a1c8280967b491bf6917a18fbff6c9b52e8df24.1641398395.git.fweimer@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/5/22 08:02, Florian Weimer wrote:
> Distributions struggle with changing the default for vsyscall
> emulation because it is a clear break of userspace ABI, something
> that should not happen.
> 
> The legacy vsyscall interface is supposed to be used by libcs only,
> not by applications.  This commit adds a new arch_prctl request,
> ARCH_VSYSCALL_CONTROL, with one argument.  If the argument is 0,
> executing vsyscalls will cause the process to terminate.  Argument 1
> turns vsyscall back on (this is mostly for a largely theoretical
> CRIU use case).
> 
> Newer libcs can use a zero ARCH_VSYSCALL_CONTROL at startup to disable
> vsyscall for the process.  Legacy libcs do not perform this call, so
> vsyscall remains enabled for them.  This approach should achieves
> backwards compatibility (perfect compatibility if the assumption that
> only libcs use vsyscall is accurate), and it provides full hardening
> for new binaries.
> 
> The chosen value of ARCH_VSYSCALL_CONTROL should avoid conflicts
> with other x86-64 arch_prctl requests.  The fact that with
> vsyscall=emulate, reading the vsyscall region is still possible
> even after a zero ARCH_VSYSCALL_CONTROL is considered limitation
> in the current implementation and may change in a future kernel
> version.
> 
> Future arch_prctls requests commonly used at process startup can imply
> ARCH_VSYSCALL_CONTROL with a zero argument, so that a separate system
> call for disabling vsyscall is avoided.
> 
> Signed-off-by: Florian Weimer <fweimer@redhat.com>
> Acked-by: Andrei Vagin <avagin@gmail.com>
> ---
> v3: Remove warning log message.  Split out test.
> v2: ARCH_VSYSCALL_CONTROL instead of ARCH_VSYSCALL_LOCKOUT.  New tests
>      for the toggle behavior.  Implement hiding [vsyscall] in
>      /proc/PID/maps and test it.  Various other test fixes cleanups
>      (e.g., fixed missing second argument to gettimeofday).
> 
> arch/x86/entry/vsyscall/vsyscall_64.c | 7 ++++++-
>   arch/x86/include/asm/mmu.h            | 6 ++++++
>   arch/x86/include/uapi/asm/prctl.h     | 2 ++
>   arch/x86/kernel/process_64.c          | 7 +++++++
>   4 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> index fd2ee9408e91..6fc524b9f232 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -174,6 +174,9 @@ bool emulate_vsyscall(unsigned long error_code,
>   
>   	tsk = current;
>   
> +	if (tsk->mm->context.vsyscall_disabled)
> +		goto sigsegv;
> +

Is there a reason you didn't just change the check earlier in the 
function to:

if (vsyscall_mode == NONE || current->mm->context.vsyscall_disabled)

Also, I still think the prctl should not be available if 
vsyscall=emulate.  Either we should fully implement it or we should not 
implement.  We could even do:

pr_warn_once("userspace vsyscall hardening request ignored because you 
have vsyscall=emulate.  Unless you absolutely need vsyscall=emulate, 
update your system to use vsyscall=xonly.\n");

and thus encourage good behavior.

--Andy
