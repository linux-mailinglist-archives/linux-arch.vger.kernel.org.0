Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0E472478B
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jun 2023 17:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjFFPWu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jun 2023 11:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbjFFPWt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jun 2023 11:22:49 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2136F10C3;
        Tue,  6 Jun 2023 08:22:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2568befcf1dso4681371a91.0;
        Tue, 06 Jun 2023 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686064965; x=1688656965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmaCuege5jcXpMt1yPmHuonlSYuQ/J3P4tHEQgu7hXs=;
        b=D00s8QkE3O4a/XWumVhxg1vg5T1HUl9fRpcfJMNTdgmiZR8yYZ18BIH3X2TNZt/GFF
         k5ZDJkndMBgNAJAYXQrnlb9wBH+AP3ekaFE2U+NmkLNcHLDPlGVl2AbMv9bLidi1RX20
         fdiPBCrkanbV5HPnDmP1JWCiCzFrWUvCAnj0m85b7uNa7wLb2ROYngSaDpfdjNzSwkZo
         eszdQ215NgScNfRNKWbMFHqe3PD2eWJ6toKy88NFs6m+w/SLgDrUs3DSSHMEiFISayrm
         suzzGUjFV1ZxDCyTYM57m5bPD8uOz5bUTS51HZ8APSIzYi626pidPtpxRQxZCV4gBRpS
         1Y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686064965; x=1688656965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LmaCuege5jcXpMt1yPmHuonlSYuQ/J3P4tHEQgu7hXs=;
        b=W4Y4YMajCzZ0uJ5LngGVLgGfb1hItcvhAfx/NvFPX73yAZDvo8LtXIsDCxtGKg7Sp8
         fwH4/l0OScaCAWPmqRtOFQPF2eeJl6mvzJVtRnXdy5WAwmd3joRvUs5H3uZND3H3fZey
         TYWv4JWWf9Zn0emcpUhI0TGJAYbTIdBRiq5dkZGbi3KNNaQFXaOqbWHStFpF1UTj6+EG
         0I+2kn4CHhlnCqhwYwmmCTCBvgV53pO4KJQWekTpmMvI/4fQ4lAinSkATulpJGv0kobT
         F6//Wkx09Fw5gQDbmXT59x42nzcw2MaksLiIgQD+tFKvzcvgsLxBr6608GSTjJY3XwYP
         EcjQ==
X-Gm-Message-State: AC+VfDzsp3Ual7vCV2z2Z05paCbX52B93hNVj7/0/q7SrXQSR3DFs1Vi
        5DWTkfmlCuC0oXcGrEdLZLU=
X-Google-Smtp-Source: ACHHUZ5Cepsp06TGWRhEUYycczrG90O+uPl1R+8lafski2iDoWml/Xh3dGP7HAXYEtuuHxQik7r2gQ==
X-Received: by 2002:a17:90a:7ac5:b0:259:b67:2a7d with SMTP id b5-20020a17090a7ac500b002590b672a7dmr3141338pjl.7.1686064965406;
        Tue, 06 Jun 2023 08:22:45 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id d7-20020a17090ad3c700b002529f2e570esm7785761pjw.28.2023.06.06.08.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 08:22:45 -0700 (PDT)
Message-ID: <4103a70f-cc09-a966-3efa-5ab9273f5c55@gmail.com>
Date:   Tue, 6 Jun 2023 23:22:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/9] x86/hyperv: Mark Hyper-V vp assist page unencrypted
 in SEV-SNP enlightened guest
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-4-ltykernel@gmail.com> <873536ksye.fsf@redhat.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <873536ksye.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/5/2023 8:13 PM, Vitaly Kuznetsov wrote:
>> @@ -113,6 +114,11 @@ static int hv_cpu_init(unsigned int cpu)
>>   
>>   	}
>>   	if (!WARN_ON(!(*hvp))) {
>> +		if (hv_isolation_type_en_snp()) {
>> +			WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
>> +			memset(*hvp, 0, PAGE_SIZE);
>> +		}
> Why do we need to set the page as decrypted here and not when we
> allocate the page (a few lines above)?

If Linux root partition boots in the SEV-SNP guest, the page still needs 
to be decrypted.

> And why do we need to clear it
> _after_  we made it decrypted? In case we care about not leaking the
> stale content to the hypervisor, we should've cleared it_before_, but
> the bigger problem I see is that memset() is problemmatic e.g. for KVM
> which uses enlightened VMCS. You put a CPU offline and then back online
> and this path will be taken. Clearing VP assist page will likely brake
> things. (AFAIU SEV-SNP Hyper-V guests don't expose SVM yet so the
> problem is likely theoretical only, but still).
> 

The page will be made dirt by hardware after decrypting operation and so 
memset the page after that.

