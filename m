Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561B572572A
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jun 2023 10:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbjFGIQd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Jun 2023 04:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238845AbjFGIQc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jun 2023 04:16:32 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8682D1BD2;
        Wed,  7 Jun 2023 01:16:11 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-33d31ab00bdso1795025ab.3;
        Wed, 07 Jun 2023 01:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686125771; x=1688717771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lHKaHlKRBzKcxVY9qtbqRsvCzEYo5afOE+RIHn1VXQ=;
        b=BDzZgP/pH5q49SPa8RpHncHkn4Q08LDmFjb3IxQmNKuuEu5Yny7OuDwgeD+OlrKUXz
         +x8FiHlJ1hh/B+RAQZpNeVdjAS+6baat0mfjI/qfLojs4km51n5vKzE3q+mDxoZKKSt6
         YE9kWrORw4uVczvTRKQJcgz8maXrpBU4FHMJQwE4Kk4EvIxBAtlGBOQPI9OYIxHF2VdB
         bWNZ3YLyjHfA5k6mltDS/C30t9hop8NgGZ4lUjVTF1tD/XXtYnMnKQOZ+RCwvcHLOtZp
         SRH8+iIMq/6m/SAgZQXX3HMFLJI9sRCWBUMl8mcLWqb85ghURDW2S6jwohC1unHJVYl/
         u3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686125771; x=1688717771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/lHKaHlKRBzKcxVY9qtbqRsvCzEYo5afOE+RIHn1VXQ=;
        b=BkYL93kg+sMkuKzv8jamMvxWSqVEinoZbXOilnU3i8wDFSyGwT9Z58UbCEIKyA/xho
         EzdiRGRaAIBH+ts4eQXmsFAlAJ/aXJwHC89BcwjUYrgbuF9xmHf0sV5SU36jBWW5uIgT
         gVN+XnoS1nA2wHaLTcy+XN9B3HFLcJifPM19wmcAfWNZ5ae2J0GoXTflu+PszQpa+3Eg
         U8tz3RP1g7M+lreeSmbhyNHtCgCtuYJAqgjrcl5FVWhXFhS+wYjpyj8b99EbHquwIw17
         D9Fy8fKf4o34MFd9Pajm/WaqLn7ehLieku/6QG9aEaKam63s7eK5TudPcWae4lrbBBl0
         GyrQ==
X-Gm-Message-State: AC+VfDxWjTJRJffp7+iMqnJyqnz0X8ZzPzqIpZK9wx1jXFMuuLKvXYXb
        bzXVLuQ0EmN8cYiFuRrMp6A=
X-Google-Smtp-Source: ACHHUZ6JRZbxoBk987Tly0PiTO2/uCJrh3Tp2DcsOU05a0kZ0UzEX3QdH47ft+pRhC0/wSIE54PcUw==
X-Received: by 2002:a92:ce45:0:b0:33b:ad04:2c31 with SMTP id a5-20020a92ce45000000b0033bad042c31mr5308840ilr.8.1686125770834;
        Wed, 07 Jun 2023 01:16:10 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id y5-20020a63ce05000000b005346b9a7fe5sm8621285pgf.22.2023.06.07.01.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 01:16:10 -0700 (PDT)
Message-ID: <2803e5d6-58bc-57f1-0721-226333238883@gmail.com>
Date:   Wed, 7 Jun 2023 16:16:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 4/9] drivers: hv: Mark shared pages unencrypted in SEV-SNP
 enlightened guest
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-5-ltykernel@gmail.com> <87zg5ejchp.fsf@redhat.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <87zg5ejchp.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/5/2023 8:54 PM, Vitaly Kuznetsov wrote:
>> @@ -402,7 +417,14 @@ int hv_common_cpu_die(unsigned int cpu)
>>   
>>   	local_irq_restore(flags);
>>   
>> -	kfree(mem);
>> +	if (hv_isolation_type_en_snp()) {
>> +		ret = set_memory_encrypted((unsigned long)mem, pgcount);
>> +		if (ret)
>> +			pr_warn("Hyper-V: Failed to encrypt input arg on cpu%d: %d\n",
>> +				cpu, ret);
>> +		/* It's unsafe to free 'mem'. */
>> +		return 0;
> Why is it unsafe to free 'mem' if ret == 0? Also, why don't we want to
> proparate non-zero 'ret' from here to fail CPU offlining?
> 

Based on Michael's patch the mem will not be freed during cpu offline.
https://lwn.net/ml/linux-kernel/87cz2j5zrc.fsf@redhat.com/
So I think it's unnessary to encrypt the mem again here.
