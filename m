Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF49E64884F
	for <lists+linux-arch@lfdr.de>; Fri,  9 Dec 2022 19:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLISQe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Dec 2022 13:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLISQc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Dec 2022 13:16:32 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E652A56FC;
        Fri,  9 Dec 2022 10:16:32 -0800 (PST)
Received: from [192.168.0.5] (71-212-113-106.tukw.qwest.net [71.212.113.106])
        by linux.microsoft.com (Postfix) with ESMTPSA id E537320B83C2;
        Fri,  9 Dec 2022 10:16:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E537320B83C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1670609792;
        bh=mPQ5Pjo/m7v+67q4Raz9XyS5DasZGKCTCRBKkqpVwoU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ShBUGDBlna8wyI2PHoqAqGDivoLGnwR+7ys0zXXEIeH005+Ss6uH19gwWvsBzQuZh
         8avQvjYV611vJ/9Jc6rDiRIseqhPR4yTrIYYolQfxhpCK4SJ9CFCY69zjVAfpkP8Yq
         3Ld9Lm6+8W2YPTzPvvhyhoK7BLmzega4+w+0X8Qg=
Subject: Re: [PATCH v8 3/5] x86/hyperv: Add an interface to do nested
 hypercalls
To:     Jinank Jain <jinankjain@linux.microsoft.com>,
        jinankjain@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, seanjc@google.com,
        kirill.shutemov@linux.intel.com, ak@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, anrayabh@linux.microsoft.com,
        mikelley@microsoft.com
References: <cover.1670561320.git.jinankjain@linux.microsoft.com>
 <ff52ba3a32325ad572780374187906775add46f2.1670561320.git.jinankjain@linux.microsoft.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
Message-ID: <45e8cd93-29a8-c80b-52a2-bde6d0c70856@linux.microsoft.com>
Date:   Fri, 9 Dec 2022 10:16:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <ff52ba3a32325ad572780374187906775add46f2.1670561320.git.jinankjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-20.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/8/2022 9:32 PM, Jinank Jain wrote:
>  /* Fast hypercall with 8 bytes of input and no output */
> -static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
> +static inline u64 _hv_do_fast_hypercall8(u64 control, u16 code, u64 input1)
>  {
> -	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
> +	u64 hv_status;

The parameter 'code' seems to be unused in this function now.
Can we just replace it with 'control'?

>  
>  #ifdef CONFIG_X86_64
>  	{
> @@ -105,10 +111,24 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
>  		return hv_status;
>  }
>  
> +static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
> +{
> +	u64 control = (u64)code | HV_HYPERCALL_FAST_BIT;
> +
> +	return _hv_do_fast_hypercall8(control, code, input1);
> +}
> +
> +static inline u64 hv_do_fast_nested_hypercall8(u16 code, u64 input1)
> +{
> +	u64 control = (u64)code | HV_HYPERCALL_FAST_BIT | HV_HYPERCALL_NESTED;
> +
> +	return _hv_do_fast_hypercall8(control, code, input1);
> +}
> +
>  /* Fast hypercall with 16 bytes of input */
> -static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
> +static inline u64 _hv_do_fast_hypercall16(u64 control, u16 code, u64 input1, u64 input2)
>  {
> -	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
> +	u64 hv_status;

Ditto

>  
>  #ifdef CONFIG_X86_64
>  	{
> @@ -139,6 +159,20 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
>  	return hv_status;
>  }
>  
> +static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
> +{
> +	u64 control = (u64)code | HV_HYPERCALL_FAST_BIT;
> +
> +	return _hv_do_fast_hypercall16(control, code, input1, input2);
> +}
> +
> +static inline u64 hv_do_fast_nested_hypercall16(u16 code, u64 input1, u64 input2)
> +{
> +	u64 control = (u64)code | HV_HYPERCALL_FAST_BIT | HV_HYPERCALL_NESTED;
> +
> +	return _hv_do_fast_hypercall16(control, code, input1, input2);
> +}

