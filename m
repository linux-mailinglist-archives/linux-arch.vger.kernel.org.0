Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D6E320FB2
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 04:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhBVDUv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Feb 2021 22:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhBVDUt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Feb 2021 22:20:49 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA58C061574;
        Sun, 21 Feb 2021 19:20:09 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d8so4266203qtn.8;
        Sun, 21 Feb 2021 19:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kVrs5X0WZfGFW9grIUDE07Lkw35+5+f1ukgRyFLIv/4=;
        b=MUHyhgguBmvIAaF581JKivK/qF5/5uwpQCvMaEtqbOO03fdLW7nKqjOagJCJqokKGN
         s4MQvNjxpKXUzVoW4VCJN0gWOy05o3lAyAfZnoxFpIJ3tlF4CmQA9CEwrV9decnjVAye
         HfFbBC98zY3jPyI3QzFt4GyS7psQ4BoiLnUxIEoRXG9fZrdVw3J63/vTD3uJkW+aqrq8
         oUj7kCg/Hvl/IIfwOzrA18QkrSjUKLtN6OARbFKe+6SWVI4XyJZna/EY7lLPU64x5fA0
         GOM2se0Fi4V3Kv74PY/nKxCQm+7VhafTTzmzN5JUXzYpvjoAtM+594+d/McVHKk2lGgu
         1Ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kVrs5X0WZfGFW9grIUDE07Lkw35+5+f1ukgRyFLIv/4=;
        b=BLT99BZ5HPE3WH7RQBQiuwcGGTvyxeoIqObxHrgtI+XZ0DkSe3F1m/2jXxxZG/YWak
         9oTFFXPORq5IYkaKuYWzKvQ7RnfGIRnFkh2tjwWcr5Px2iYSY4ifRB0153yruLtJDk4S
         hXuuVWBeLB1wP+aXyKOGasjY+tnptOLsjau1wxJh57Lvk92zcWLuxBTv6c3bpIZRPNfq
         PJO5KxOcybwrlpGk78RqLO6aP9i+nDG81wXwqxVloaSDpoAu1Lv1Cc+yqKtDRaiWF0SI
         /wBxP+EMYAsReR3maMQUjFtj4X/Fmv+iV9T8SvERFYX0wG0edokEGMTV0jkJBsHvdY4q
         xAXQ==
X-Gm-Message-State: AOAM533K6vEByNQD8pNaeNVw7+RGgm51txDQ0FLWIXcgvHDYq18oLbbx
        pY55zb1aF9SdbJxkhA8NJA0=
X-Google-Smtp-Source: ABdhPJxESTWoh7v6e7qKkW/kLbXVxXfZ+xFT99qQMPR4l8PN2xK/tF2rfHxdz4AVrGIpER7fqBKk/Q==
X-Received: by 2002:ac8:4e04:: with SMTP id c4mr18379586qtw.205.1613964008848;
        Sun, 21 Feb 2021 19:20:08 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id f8sm10044139qth.6.2021.02.21.19.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 19:20:08 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id E8B4F27C0054;
        Sun, 21 Feb 2021 22:20:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 21 Feb 2021 22:20:07 -0500
X-ME-Sender: <xms:5iIzYH9JmUzkVzY6fnBwcYx25pH_SNBXD8DEEoqXs2a8nDCtl7LMtw>
    <xme:5iIzYDuBVoAMLSrGWL5MtnGxhyf3CVG94K7Yx3Y9jcvEcqhuHxOvm-Ij8iseKDYLO
    BCasM_p8EOsaxCviA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkedvgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeiffdviedtteehffduudfggfegvdejjeeiffehledtgefhheeuheetheelgeeh
    ffenucfkphepudefuddruddtjedrudegjedruddvieenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:5iIzYFBgtKA8QtyXKU-nKjzgs4Zojg6tGKB2UOKebvgHdUmjEgvCNQ>
    <xmx:5iIzYDdO-OmkSx_Volr49Es9boMjhS6J3_IGRh9BzBr0FUD5AsPB0w>
    <xmx:5iIzYMN79r37f-GI67Q5_0F61atfEVwPKKetNV9xD5RClsfBzwb3lQ>
    <xmx:5yIzYIle9C2LEFaPAXGkUo1VQ_5bMXFwaYyykmYM__PUhwwVTYB2weDFkFc>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id E22E4108005F;
        Sun, 21 Feb 2021 22:20:05 -0500 (EST)
Date:   Mon, 22 Feb 2021 11:19:33 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 02/10] x86/hyper-v: Move hv_message_type to architecture
 neutral module
Message-ID: <YDMixTmbTXiTuhYw@boqun-archlinux>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
 <1611779025-21503-3-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611779025-21503-3-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 27, 2021 at 12:23:37PM -0800, Michael Kelley wrote:
> The definition of enum hv_message_type includes arch neutral and
> x86/x64-specific values. Ideally there would be a way to put the
> arch neutral values in an arch neutral module, and the arch
> specific values in an arch specific module. But C doesn't provide
> a way to extend enum types. As a compromise, move the entire
> definition into an arch neutral module, to avoid duplicating the
> arch neutral values for x86/x64 and for ARM64.
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 29 -----------------------------
>  include/asm-generic/hyperv-tlfs.h  | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 6bf42ae..dd74066 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -263,35 +263,6 @@ struct hv_tsc_emulation_status {
>  #define HV_X64_MSR_TSC_REFERENCE_ENABLE		0x00000001
>  #define HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT	12
>  
> -
> -/* Define hypervisor message types. */
> -enum hv_message_type {
> -	HVMSG_NONE			= 0x00000000,
> -
> -	/* Memory access messages. */
> -	HVMSG_UNMAPPED_GPA		= 0x80000000,
> -	HVMSG_GPA_INTERCEPT		= 0x80000001,
> -
> -	/* Timer notification messages. */
> -	HVMSG_TIMER_EXPIRED		= 0x80000010,
> -
> -	/* Error messages. */
> -	HVMSG_INVALID_VP_REGISTER_VALUE	= 0x80000020,
> -	HVMSG_UNRECOVERABLE_EXCEPTION	= 0x80000021,
> -	HVMSG_UNSUPPORTED_FEATURE	= 0x80000022,
> -
> -	/* Trace buffer complete messages. */
> -	HVMSG_EVENTLOG_BUFFERCOMPLETE	= 0x80000040,
> -
> -	/* Platform-specific processor intercept messages. */
> -	HVMSG_X64_IOPORT_INTERCEPT	= 0x80010000,
> -	HVMSG_X64_MSR_INTERCEPT		= 0x80010001,
> -	HVMSG_X64_CPUID_INTERCEPT	= 0x80010002,
> -	HVMSG_X64_EXCEPTION_INTERCEPT	= 0x80010003,
> -	HVMSG_X64_APIC_EOI		= 0x80010004,
> -	HVMSG_X64_LEGACY_FP_ERROR	= 0x80010005
> -};
> -
>  struct hv_nested_enlightenments_control {
>  	struct {
>  		__u32 directhypercall:1;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index e73a118..d06f7b1 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -213,6 +213,41 @@ enum HV_GENERIC_SET_FORMAT {
>  #define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
>  #define HV_MESSAGE_PAYLOAD_QWORD_COUNT	(30)
>  
> +/*
> + * Define hypervisor message types. Some of the message types
> + * are x86/x64 specific, but there's no good way to separate
> + * them out into the arch-specific version of hyperv-tlfs.h
> + * because C doesn't provide a way to extend enum types.
> + * Keeping them all in the arch neutral hyperv-tlfs.h seems
> + * the least messy compromise.
> + */
> +enum hv_message_type {
> +	HVMSG_NONE			= 0x00000000,
> +
> +	/* Memory access messages. */
> +	HVMSG_UNMAPPED_GPA		= 0x80000000,
> +	HVMSG_GPA_INTERCEPT		= 0x80000001,
> +
> +	/* Timer notification messages. */
> +	HVMSG_TIMER_EXPIRED		= 0x80000010,
> +
> +	/* Error messages. */
> +	HVMSG_INVALID_VP_REGISTER_VALUE	= 0x80000020,
> +	HVMSG_UNRECOVERABLE_EXCEPTION	= 0x80000021,
> +	HVMSG_UNSUPPORTED_FEATURE	= 0x80000022,
> +
> +	/* Trace buffer complete messages. */
> +	HVMSG_EVENTLOG_BUFFERCOMPLETE	= 0x80000040,
> +
> +	/* Platform-specific processor intercept messages. */
> +	HVMSG_X64_IOPORT_INTERCEPT	= 0x80010000,
> +	HVMSG_X64_MSR_INTERCEPT		= 0x80010001,
> +	HVMSG_X64_CPUID_INTERCEPT	= 0x80010002,
> +	HVMSG_X64_EXCEPTION_INTERCEPT	= 0x80010003,
> +	HVMSG_X64_APIC_EOI		= 0x80010004,
> +	HVMSG_X64_LEGACY_FP_ERROR	= 0x80010005
> +};
> +
>  /* Define synthetic interrupt controller message flags. */
>  union hv_message_flags {
>  	__u8 asu8;
> -- 
> 1.8.3.1
> 
