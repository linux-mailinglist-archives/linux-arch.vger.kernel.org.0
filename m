Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221841D114D
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 13:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgEML22 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 07:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgEML21 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 07:28:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59E5C061A0C;
        Wed, 13 May 2020 04:28:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 50so19899528wrc.11;
        Wed, 13 May 2020 04:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=umGv6fGxsWryLw9NkuknLx6F4a8s0iVFY2+FuwePS84=;
        b=OfUWDIM9m7FIQ6koJKsYLqgDmwiyBWA+0K8phN3KfRTjHfFEA2rpy/cZ/85mCF3FuK
         9dm5BtwNSvkGyTZXeZHmZMHx1uhMViO7o0Bs8LDz2Nc59rctl0FGCJVI3lxFIYKY7RJo
         Az791hdUQ8TvdQHwlOePfOKxtXHPli/MFwxd0iE/MvP1kaRgvoZPW1kOXiPCJX6Soc+T
         DkhyESW95zsMQl3zLGaZJAUaSBARiT78Gzz7IXwN2Cu/ib7gkb9pDUW4+IvbsJe3Y5UX
         jkjbn7Z1PHgK27c/pq0aakhEW5azZb61zyuAFb59EdXuCl3CeqF0aMjxX6Xh+oCa8L4U
         tG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=umGv6fGxsWryLw9NkuknLx6F4a8s0iVFY2+FuwePS84=;
        b=XksiZM8rH4C6Fb9nS+5m22w81xwAK3u5Q8jgiS7/pt4u+dUMOmMF9Zq7BIk5Z/OXVR
         7EtQ6sdQmBwm7b3HehwiqyIMoWQ5E/Qs78hJl0nXVhXdV/c6/twcNgHMFVLOw3oNVy20
         S5XKpBRjlDC5hVUb/hz5KCiStwUMFSkMLXHMATfvDKpDvr7E0GYj1T9z+NBmT6RGtLZs
         RkkXA9fV1OK2phveYlBUtb60a1MW4mkdCQXHyyKiyLErRVDUkIQ1r7n7C7JoodOpNyI2
         dXgulkW8VoY9uevpbZr0kf9D9WbUJEpaQITQZ/jEa+l3Bw/+pYDHktD677V1o38IZzdW
         3pbQ==
X-Gm-Message-State: AGi0PubzZj+5V8r3LUcAJrYN+3sXkBfpREHbWfQhKYHdPp1zqQ/Vcler
        chF8we0dtsP81IVElDXSnBc=
X-Google-Smtp-Source: APiQypLKV2kRCLV0sXQ+nz+gAx8i0jDBHLjTjuZgG89d3qYjUxg8ACuzVplsbAVp6QBB2M9TL7vGPQ==
X-Received: by 2002:adf:afdb:: with SMTP id y27mr29180414wrd.323.1589369304662;
        Wed, 13 May 2020 04:28:24 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id 32sm27509151wrg.19.2020.05.13.04.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 04:28:24 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 00/14] prctl.2 man page updates for Linux 5.6
To:     Dave Martin <Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <29a02b16-dd61-6186-1340-fcc7d5225ad0@gmail.com>
Date:   Wed, 13 May 2020 13:28:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave,

On 5/12/20 6:36 PM, Dave Martin wrote:
> A bunch of updates to the prctl(2) man page to fill in the missing
> prctls (mostly) up to Linux 5.6 (along with a few other tweaks fixes).
> 
> People not Cc'd on the whole series can find the whole series at
> https://lore.kernel.org/linux-man/ .
> 
> Patches:
> 
>  * Patches 1-6 and 8-9 are rather trivial optional tweaks and fixes
>    that don't make substantive changes.  I can live with some of these
>    being dropped.
> 
>  * Patch 7 (removal of the MPX prctls) could use an Ack, but should be
>    uncontroversial.
> 
>  * Patches 10-11 cover recent extensions to the speculation control
>    prctls.
> 
>  * Patch 12 adds one particular case Errors for EINVAL, applicable to
>    all arch-specific prctls.  I've not tried too hard to be 100%
>    comprehensive with the error conditions, since the list in its
>    current form looks in need of a major overhaul.
> 
>  * Patches 13-14 add the new arm64-specific prctls.
>    (PR_SET_TAGGED_ADDR_CTRL requires a bit more discussion and will be
>    posted separately.)

Thanks. This is great!

> Maintainer notes:
> 
>  * I'm *asssuming* that the datestamps in .TH are automatically
>    updated by maintainer scripts, since maintaining them by hand would
>    interact very badly with rebase.  If needed I can go update them by
>    hand though.
> 
>  * Similarly, in the days of git (and because I see no recent entries)
>    I'm assuming that in-file changelogs no longer need to be updated.

Correct.

>    Again, I'm happy to do that if needed.

(No need.)

Except as noted below, patches have been applied:

> Dave Martin (14):
>   prctl.2: tfix clarify that prctl can apply to threads
>   prctl.2: Add health warning
>   prctl.2: tfix mis-description of thread ID values in procfs
>   prctl.2: srcfix add comments for navigation
>   prctl.2: tfix listing order of prctls
>   prctl.2: ffix quotation mark tweaks
>   prctl.2: Document removal of Intel MPX prctls
>   prctl.2: Work around bogus constant "maxsig" in PR_SET_PDEATHSIG
>   prctl.2: tfix minor punctuation in SPECULATION_CTRL prctls
>   prctl.2: Add PR_SPEC_INDIRECT_BRANCH for SPECULATION_CTRL prctls

Applied, but not yet pushed.

>   prctl.2: Add PR_SPEC_DISABLE_NOEXEC for SPECULATION_CTRL prctls

Applied, but not yet pushed.

>   prctl.2: Clarify the unsupported hardware case of EINVAL
>   prctl.2: Add SVE prctls (arm64)

Will had comments. I'm presuming there will be a v2 of this patch.

>   prctl.2: Add PR_PAC_RESET_KEYS (arm64)

Will had comments. I'm presuming there will be a v2 of this patch.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
