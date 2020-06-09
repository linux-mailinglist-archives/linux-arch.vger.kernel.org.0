Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213E51F39E3
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jun 2020 13:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgFILjL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Jun 2020 07:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgFILjH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2020 07:39:07 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3867AC05BD1E;
        Tue,  9 Jun 2020 04:39:07 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l26so2498268wme.3;
        Tue, 09 Jun 2020 04:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uYBS2FbTJMkU9K9/sTTekDcE8lAuwYxQs0Enyn0GFh4=;
        b=UPXSXzPadNXtpPBG+b3ISY5Q3wkVYIv2Hk6fFpgKOqcuYQdxfQ/6zWBT37nJfM2K8r
         mJM6TV9Fc2nR4nDCvRm8FUtNs+V5AYVyBSuAtE2lTwAncgZyMUyytvembRs+oKiPlGaB
         evOYzeI2rw+x0g0qCqJD6XrRLfA4AkW+huoQvf3oEqzuc/gUkor0l6ENFzqk/SWZcf6+
         bcSYuN3QRzumHgNFKHPnonAtTuvTOtM94SexLrdvKW6BioDUFCQQxPLbCQR/R/iSJ+RH
         42AuEneFsGYdRvL+xTfAKieqVCdpPloRBcPpjpYoWRFpc+7HLNlm4xczpd7+gJul25X4
         vLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uYBS2FbTJMkU9K9/sTTekDcE8lAuwYxQs0Enyn0GFh4=;
        b=LMq3c2enyAks57I4CVEMO2RzXHdLetC2LCZx7jumasI/I04x9YY+KIuDQd/ZOguq0/
         FBpDaN90Jslz75caa1F6pMxa/PAo+3cvYi3H3Z0X3Sxk05mo204nDnrnyjaoicS0DizH
         EHe+DIKHo507UliT9F1uYJWzuBO+I1sSJczAapj01nxKyTprM+0Jq0PgtA5FCKR3WsqN
         LHIPnKUtnXczCjZ1GzDqkNaaCDfwXX9msqCFSf3q+SnZo9ySpTKbRVgvOxGDG4W46wFE
         q5apUsQ+WKehVXoC/qFg2SfODfzt9ZoAZIdsJAEIF7PNoSo+ICpOhJB9KUh3olcCd6wI
         Qhpg==
X-Gm-Message-State: AOAM531TFa2omNKxjG+NSgVZH5eDS4oxVXTpHkAscZQ1MrrjLO7VSXC9
        2RSFOSHlFXogBpPidYUEiI0=
X-Google-Smtp-Source: ABdhPJxD1b9Epq9ZFQsaro+YuV3OpFvitZIyBXepQBnhScmhuVbBvwN5cbdKGpjZ0+sSkLK8kdc/Ug==
X-Received: by 2002:a1c:4189:: with SMTP id o131mr3234375wma.183.1591702744556;
        Tue, 09 Jun 2020 04:39:04 -0700 (PDT)
Received: from ?IPv6:2001:a61:253c:8201:b2fb:3ef8:ca:1604? ([2001:a61:253c:8201:b2fb:3ef8:ca:1604])
        by smtp.gmail.com with ESMTPSA id s8sm3166724wrm.96.2020.06.09.04.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 04:39:04 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 4/6] prctl.2: Add SVE prctls (arm64)
To:     Dave Martin <Dave.Martin@arm.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-5-git-send-email-Dave.Martin@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <77b02e4a-bfcf-90ef-90ca-73e878b7b649@gmail.com>
Date:   Tue, 9 Jun 2020 13:39:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1590614258-24728-5-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave,

I've not applied this patch yet, in case you want to make
some changes in response to Will's comments.

I think all of the rest of the patches in the series are now
applied (and pushed to master).

Thanks,

Michael

On 5/27/20 11:17 PM, Dave Martin wrote:
> Add documentation for the the PR_SVE_SET_VL and PR_SVE_GET_VL
> prctls added in Linux 4.15 for arm64.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> 
> ---
> 
> Since v1:
> 
>  * Minor rewordings and typo fixes.
> 
>  * Fix typo'd #define names.
> 
>  * Add type annotation for PR_SVE_SET_VL arg2.
> 
>  * Clarify return value semantics of PR_SVE_SET_VL
> 
>  * Add note to say that the args for PR_SVE_GET_VL are ignored.
> 
>  * Note for PR_SVE_SET_VL that the PR_SVE_VL_LEN_MASK field specifies
>    an upper bound on what vector length to set, not an exact value.
> 
>  * Rework PR_SVE_SET_VL arg2 description to enumerate all possible flag
>    combinations rather than describing the flags independently.
> 
>    Coming up with a clear description of each flag that is independent
>    of the description of the other flag turns out to be hard.
> 
>  * In lieu of having a separate man page to cross reference for detailed
>    guidance, cross-reference the kernel documentation.
> 
>  * Avoid confusing cross-reference to PR_SVE_SET_VL when describing the
>    return value of PR_SVE_GET_VL.
> 
>  * Clarify error conditions for PR_SVE_SET_VL and PR_SVE_GET_VL, and
>    move detail to the individual prctl descriptions to keep related
>    content close together while minimising duplication.
> 
>  * Add safety warning.  This is deliberately vague, pending ongoing
>    discussions with libc folks.
> ---
>  man2/prctl.2 | 160 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 160 insertions(+)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index cab9915..91df7c8 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -1291,6 +1291,148 @@ call failing with the error
>  .BR ENXIO .
>  For further details, see the kernel source file
>  .IR Documentation/admin\-guide/kernel\-parameters.txt .
> +.\" prctl PR_SVE_SET_VL
> +.\" commit 2d2123bc7c7f843aa9db87720de159a049839862
> +.\" linux-5.6/Documentation/arm64/sve.rst
> +.TP
> +.BR PR_SVE_SET_VL " (since Linux 4.15, only on arm64)"
> +Configure the thread's SVE vector length,
> +as specified by
> +.IR "(int) arg2" .
> +Arguments
> +.IR arg3 ", " arg4 " and " arg5
> +are ignored.
> +.IP
> +The bits of
> +.I arg2
> +corresponding to
> +.B PR_SVE_VL_LEN_MASK
> +must be set to the desired vector length in bytes.
> +This is interpreted as an upper bound:
> +the kernel will select the greatest available vector length
> +that does not exceed the value specified.
> +In particular, specifying
> +.B SVE_VL_MAX
> +(defined in
> +.I <asm/sigcontext.h>)
> +for the
> +.B PR_SVE_VL_LEN_MASK
> +bits requests the maximum supported vector length.
> +.IP
> +In addition,
> +.I arg2
> +must be set to one of the following combinations of flags:
> +.RS
> +.TP
> +.B 0
> +Perform the change immediately.
> +At the next
> +.BR execve (2)
> +in the thread,
> +the vector length will be reset to the value configured in
> +.IR /proc/sys/abi/sve_default_vector_length .
> +.TP
> +.B PR_SVE_VL_INHERIT
> +Perform the change immediately.
> +Subsequent
> +.BR execve (2)
> +calls will preserve the new vector length.
> +.TP
> +.B PR_SVE_SET_VL_ONEXEC
> +Defer the change, so that it is performed at the next
> +.BR execve (2)
> +in the thread.
> +Further
> +.BR execve (2)
> +calls will reset the vector length to the value configured in
> +.IR /proc/sys/abi/sve_default_vector_length .
> +.TP
> +.B "PR_SVE_SET_VL_ONEXEC | PR_SVE_VL_INHERIT"
> +Defer the change, so that it is performed at the next
> +.BR execve (2)
> +in the thread.
> +Further
> +.BR execve (2)
> +calls will preserve the new vector length.
> +.RE
> +.IP
> +In all cases,
> +any previously pending deferred change is canceled.
> +.IP
> +The call fails with error
> +.B EINVAL
> +if SVE is not supported on the platform, if
> +.I arg2
> +is unrecognized or invalid, or the value in the bits of
> +.I arg2
> +corresponding to
> +.B PR_SVE_VL_LEN_MASK
> +is outside the range
> +.BR SVE_VL_MIN .. SVE_VL_MAX
> +or is not a multiple of 16.
> +.IP
> +On success,
> +a nonnegative value is returned that describes the
> +.I selected
> +configuration,
> +which may differ from the current configuration if
> +.B PR_SVE_SET_VL_ONEXEC
> +was specified.
> +The value is encoded in the same way as the return value of
> +.BR PR_SVE_GET_VL .
> +.IP
> +The configuration (including any pending deferred change)
> +is inherited across
> +.BR fork (2)
> +and
> +.BR clone (2).
> +.IP
> +.B Warning:
> +Because the compiler or run-time environment
> +may be using SVE, using this call without the
> +.B PR_SVE_SET_VL_ONEXEC
> +flag may crash the calling process.
> +The conditions for using it safely are complex and system-dependent.
> +Don't use it unless you really know what you are doing.
> +.IP
> +For more information, see the kernel source file
> +.I Documentation/arm64/sve.rst
> +.\"commit b693d0b372afb39432e1c49ad7b3454855bc6bed
> +(or
> +.I Documentation/arm64/sve.txt
> +before Linux 5.3).
> +.\" prctl PR_SVE_GET_VL
> +.TP
> +.BR PR_SVE_GET_VL " (since Linux 4.15, only on arm64)"
> +Get the thread's current SVE vector length configuration.
> +.IP
> +Arguments
> +.IR arg2 ", " arg3 ", " arg4 " and " arg5
> +are ignored.
> +.IP
> +Providing that the kernel and platform support SVE
> +this operation always succeeds,
> +returning a nonnegative value that describes the
> +.I current
> +configuration.
> +The bits corresponding to
> +.B PR_SVE_VL_LEN_MASK
> +contain the currently configured vector length in bytes.
> +The bit corresponding to
> +.B PR_SVE_VL_INHERIT
> +indicates whether the vector length will be inherited
> +across
> +.BR execve (2).
> +.IP
> +Note that there is no way to determine whether there is
> +a pending vector length change that has not yet taken effect.
> +.IP
> +For more information, see the kernel source file
> +.I Documentation/arm64/sve.rst
> +.\"commit b693d0b372afb39432e1c49ad7b3454855bc6bed
> +(or
> +.I Documentation/arm64/sve.txt
> +before Linux 5.3).
>  .\"
>  .\" prctl PR_TASK_PERF_EVENTS_DISABLE
>  .TP
> @@ -1534,6 +1676,8 @@ On success,
>  .BR PR_GET_NO_NEW_PRIVS ,
>  .BR PR_GET_SECUREBITS ,
>  .BR PR_GET_SPECULATION_CTRL ,
> +.BR PR_SVE_GET_VL ,
> +.BR PR_SVE_SET_VL ,
>  .BR PR_GET_THP_DISABLE ,
>  .BR PR_GET_TIMING ,
>  .BR PR_GET_TIMERSLACK ,
> @@ -1817,6 +1961,22 @@ and unused arguments to
>  .BR prctl ()
>  are not 0.
>  .TP
> +.B EINVAL
> +.I option
> +is
> +.B PR_SVE_SET_VL
> +and the arguments are invalid or unsupported,
> +or SVE is not available on this platform.
> +See the description of
> +.B PR_SVE_SET_VL
> +above for details.
> +.TP
> +.B EINVAL
> +.I option
> +is
> +.B PR_SVE_GET_VL
> +and SVE is not available on this platform.
> +.TP
>  .B ENODEV
>  .I option
>  was
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
