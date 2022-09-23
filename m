Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70DA5E784E
	for <lists+linux-arch@lfdr.de>; Fri, 23 Sep 2022 12:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIWK3N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Sep 2022 06:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiIWK2l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Sep 2022 06:28:41 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2317F12ED86;
        Fri, 23 Sep 2022 03:28:40 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id t7so19672815wrm.10;
        Fri, 23 Sep 2022 03:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=OCZ/F0HrnTTtm97NDW9M9Tgyn70w4D8p3nQznpQwDv8=;
        b=mDRFLfmWFzqbUrpb3WKlPhSxhZ1xOsM2YL/VPBETqEJX9MTOhZlcMpQLZkxOvDC5ZI
         EEYjEhvhYSZQ9ihjkgQS1sgEXqntDiQiNv0kDdZOW/DoWg/pd/uj1cGvBqvbQ8E4C+tS
         SG4QXpAflEei7eCl1FdUnWOBkjIc4GvpGRlD8k1X1PwARNCfm5k8VUHmJGhwPjQt0FY5
         i7Z0ayY+fRgxXyB7cHJpKEKLzspw52SHnpHOhlBAqmWgGoEpwbcU+qEE12zLoNp4bkvi
         4Vn6kwJSpRq6BLo2wfmY0qgfYSKLLD/bzGmQSItEEVodLegM8udaPhkC7+GUzCkf0n3G
         /b9w==
X-Gm-Message-State: ACrzQf2e/Bd9ST+1lA/dD0rmBYSlh+DzY81YKU2HHDHtLd+SvDoYIk1U
        fOXWY1x8WeagY8IV6AwHHjg=
X-Google-Smtp-Source: AMsMyM6ReHmiL0VAv9tsouVLQLi1H9NIY57WE7jvQxO0L+Gqhf49wPXtahs+x4ZQsAC7C8GqzibFfw==
X-Received: by 2002:a5d:64e5:0:b0:22a:3cae:93bf with SMTP id g5-20020a5d64e5000000b0022a3cae93bfmr4833236wri.323.1663928918727;
        Fri, 23 Sep 2022 03:28:38 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x12-20020adfffcc000000b0022ac672654dsm6976948wrs.58.2022.09.23.03.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 03:28:38 -0700 (PDT)
Date:   Fri, 23 Sep 2022 10:28:36 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, arnd@arndb.de, linux-hyperv@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] asm-generic: Remove the parameters of the
 generate_guest_id function and modify the return type and modify the
 function name
Message-ID: <Yy2KVM08HMiv46d6@liuwe-devbox-debian-v2>
References: <20220920032837.69469-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920032837.69469-1-kunyu@nfschina.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Kunyu

The subject line is far too long.

Please change it to

hyperv: simplify and rename generate_guest_id

On Tue, Sep 20, 2022 at 11:28:37AM +0800, Li kunyu wrote:
> The generate_guest_id function is more suitable for use after the
> following modifications.
> 1. Modify the type of the guest_id variable to u64, which is compatible
> with the caller.
> 2. Remove all parameters from the function, and write the parameter
> (LINUX_VERSION_CODE) passed in by the actual call into the function
> implementation.
> 3. Rename the function to make it clearly a Hyper-V related function,
> and modify it to hv_generate_guest_id.
> 
> v2:
>   Fix generate_guest_id to hv_generate_guest_id.

The patch version information shouldn't be part of the commit message.
You can use scissors to separate them

---8<---
 v2: ...

When the patch gets applied, text after the scissors will be stripped
automatically.

> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>

BTW, the previous patch was submitted by Li Zeming. Did you two agree on
who to take this forward?

> ---
>  arch/arm64/hyperv/mshyperv.c   |  2 +-
>  arch/x86/hyperv/hv_init.c      |  2 +-
>  include/asm-generic/mshyperv.h | 12 +++++-------
>  3 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index bbbe351e9045..3863fd226e0e 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -38,7 +38,7 @@ static int __init hyperv_init(void)
>  		return 0;
>  
>  	/* Setup the guest ID */
> -	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
> +	guest_id = hv_generate_guest_id();
>  	hv_set_vpreg(HV_REGISTER_GUEST_OSID, guest_id);
>  
>  	/* Get the features and hints from Hyper-V */
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 3de6d8b53367..93770791b858 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -426,7 +426,7 @@ void __init hyperv_init(void)
>  	 * 1. Register the guest ID
>  	 * 2. Enable the hypercall and register the hypercall page
>  	 */
> -	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
> +	guest_id = hv_generate_guest_id();
>  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
>  
>  	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index c05d2ce9b6cd..7f4a23cee56f 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -25,6 +25,7 @@
>  #include <linux/nmi.h>
>  #include <asm/ptrace.h>
>  #include <asm/hyperv-tlfs.h>
> +#include <linux/version.h>
>  
>  struct ms_hyperv_info {
>  	u32 features;
> @@ -105,15 +106,12 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
>  }
>  
>  /* Generate the guest OS identifier as described in the Hyper-V TLFS */
> -static inline  __u64 generate_guest_id(__u64 d_info1, __u64 kernel_version,
> -				       __u64 d_info2)
> +static inline  u64 hv_generate_guest_id(void)
                ^^
		There are two spaces. We only need one.

I know it is not introduced by you, but since you're modifying the code
anyway, you may as well drop the extraneous space.

>  {
> -	__u64 guest_id = 0;
> +	u64 guest_id;
>  
> -	guest_id = (((__u64)HV_LINUX_VENDOR_ID) << 48);
> -	guest_id |= (d_info1 << 48);
> -	guest_id |= (kernel_version << 16);
> -	guest_id |= d_info2;
> +	guest_id = (((u64)HV_LINUX_VENDOR_ID) << 48);
> +	guest_id |= (((u64)LINUX_VERSION_CODE) << 16);
>  
>  	return guest_id;
>  }
> -- 
> 2.18.2
> 
