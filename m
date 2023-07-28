Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E57766AF3
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jul 2023 12:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjG1KqJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jul 2023 06:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbjG1KqI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jul 2023 06:46:08 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C438A0;
        Fri, 28 Jul 2023 03:46:05 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bbc2e1c6b2so12920665ad.3;
        Fri, 28 Jul 2023 03:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690541164; x=1691145964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPaup7cUyVRbpTRQswB0viHDK7comrm26phPHKmAKzI=;
        b=Fi3Jsfr/+uQ1WuimMMOFiC7VTQSiKAH57Dy7rLtpa0KUxXB02PiP3TRa/+iWga7uC7
         bcmhfoHiBbFwaFRZ3zvdzZOrEuZJ2qXGFCwSoi3R1I6KXiO4GGGnhd8ZfqsN+5BJk8dP
         AaFNZPhtufvUsPvUhXzRCTAb4IhFXEvGkz2OF8n0/qXHG78bOxcuMCLWJJ0qhER0vmjV
         8rf8NfnTxEGftz/fRKlVPl5Qoeaiz4NQ3wcSPJdJ0FaT0nLapQ/W2mFmFJdA/I/9z0VG
         hSt7iz4Xavn97uvO3BPAQI9WQlpeuRFmoBOyubybOSgl6+flPRJzCnxYMSs3lmJ9RgEH
         75ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690541164; x=1691145964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nPaup7cUyVRbpTRQswB0viHDK7comrm26phPHKmAKzI=;
        b=VOCu494FfuRUFkcY4Uowd4FKeJh0mu7aezp4ZFGOQcHq6WWBgg418fNY5fSKL+ciXp
         lRxzgR6IGhcnrBvtnnvDMMgGRiEpQ0zY1vrwSIpTz0Eet5HFdjMhzlER4yVQWcQEXxS9
         Nsz7H1AExDwM2QuBpt/YAY5k20MQsVb9mW9p+63A4deWJ76eCvZvgA1o03/cdCyqMBuQ
         wtiejSWutK1w2tV0JyUB0LGleEUJTy8xsCiRsYmSgq6T6sZgYRSpXdWxr+5qGroQ4ZSu
         6ThUlI+CgVpHzgvpCFO9oef6CxBjC/5ajYY7XHQQfkUvGEUx4bexLQiPJ/YtR6rq1ssu
         +FSg==
X-Gm-Message-State: ABy/qLZTVVx7JRCmXyHtImT/whHBYNgiWHc8lHlaySCSni9ukom2szth
        s4TyyUUiC3DlgFMELmq5iwo=
X-Google-Smtp-Source: APBJJlEp8OfeRIGgcYdWOg4/SHQSfmeHRo51elGMyHJ+bImcPqLh3vBKYSv3JjL5KaKxE+IKnV3zUw==
X-Received: by 2002:a17:902:f547:b0:1b8:b827:aa8e with SMTP id h7-20020a170902f54700b001b8b827aa8emr1026011plf.11.1690541164368;
        Fri, 28 Jul 2023 03:46:04 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id ix17-20020a170902f81100b001b3d0aff88fsm3285386plb.109.2023.07.28.03.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 03:46:02 -0700 (PDT)
Message-ID: <36b73cf6-4594-c9b2-2896-cd0dd49f8974@gmail.com>
Date:   Fri, 28 Jul 2023 18:45:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH V3 5/9] x86/hyperv: Use vmmcall to implement Hyper-V
 hypercall in sev-snp enlightened guest
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
References: <20230718032304.136888-1-ltykernel@gmail.com>
 <20230718032304.136888-6-ltykernel@gmail.com>
 <BYAPR21MB16882FAEDEFAED59208ED9E0D700A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <89c9f27c-f539-ef75-dc67-bdb0a8480c4b@gmail.com>
 <BYAPR21MB16880B1657BA4C907D002730D700A@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB16880B1657BA4C907D002730D700A@BYAPR21MB1688.namprd21.prod.outlook.com>
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

On 7/26/2023 10:29 PM, Michael Kelley (LINUX) wrote:
>> Hi Michael:
>> 	Thanks for your review. The patch mentioned by Boris has not been
>> merged and so still use X86_FEATURE_SEV_ES here. We may replace the
>> feature flag with X86_FEATURE_SEV_SNP after it's upstreamed.
>>
> Just so I'm clear, is it true that in an SEV-SNP VM, the CPUID flags for
> SEV-ES*and*  SEV-SNP are set?  That would seem to be necessary for
> your approach to work.

Yes, SEV and SEV-ES flags are set in the SEV-SNP guest and they are 
necessary.

> 
> I wonder if it would be better to take the patch from Brijesh Singh
> that adds X86_FEATURE_SEV_SNP and add it to your patch set (with
> Brijesh's agreement, of course).  That patch is small and straightforward.
>

I will sync with Brijesh. Thanks for suggestion.

