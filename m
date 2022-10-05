Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEA75F51B6
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 11:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiJEJZx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 05:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJEJZw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 05:25:52 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E96558FA;
        Wed,  5 Oct 2022 02:25:51 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 67so1094373pfz.12;
        Wed, 05 Oct 2022 02:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=izOq3nhW8PlF5udp1yxZvcnLpgOly1zNCF8yx+bEypo=;
        b=igDoZw39cpPcFKBATmvS0n8RrR+ocDjZAWBIAW5hJ43l4gh2MFwghu5UV+w88CPw0I
         i7WdzUCsXp4g8I6HY1ld9h2VxkymyQK7u60ZbwIlxHrta5RpdFzwghFKQKOT1Flz/PQ2
         TqXIUz2totbmPox1N1a8i6Do5Xe6vMwZWkvGWaLTGzcCa5niQA8Ru3fRD6pw5ArrnZMO
         DIk6tYpylBpPg5AI3/xVOQ3jE38uXDH7qYAiTnrZTY5hQTOIEbTjnZQL1kNU59MCpPFz
         lZW4qPmdbTTmjdaCj4T0o0XIzVnb4ISx3Wt1D39Bn9sLmGMJqHms2J8pQlg0S2TFNbaj
         t7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izOq3nhW8PlF5udp1yxZvcnLpgOly1zNCF8yx+bEypo=;
        b=2YkwO7p7B0J5pRGVs4UtPN0b5AwoTnLuMcbY7/PLSfmqImyLgW5WJcGyrBicQtWe4I
         GG93iY+oSk9ChZUppJV33nKzJjDPMVF6wwUDq5nCJiZs1e4+md6+BN1PhhR3n7BXIPEV
         AjsLqVPoLqDX4AE6WFM1b+SomwAMx+qIevB3/ccUwBHsp5SNaL5iPfhfYPusNlzMVz9f
         pVRT22xIKZ93ip8cXjs8iS68tteGyGJe4hF/OlV6TOpyf81sbpzhgtXuEo4De5EW+jW5
         8tasc9ZEt16pCllC970nzwI5ZexFoqP++mhz3g+sV4wykWPegieoz0rbdeqbIYV5Elm3
         IIDg==
X-Gm-Message-State: ACrzQf082FVDWWkMPxNQNk0lta0w86mIAq/qgfwu/LIya/3MyBsL6RUH
        0Qe869gwCNNKOh1kbjJNYyU=
X-Google-Smtp-Source: AMsMyM4nRrzknrIo9rTE2rjnPSrl6+nPOxqW1Ndzb7Lrr/SqGD0sXGDVTPcVTesXGhS6RYukukrLFg==
X-Received: by 2002:a05:6a00:194a:b0:561:a950:c2e0 with SMTP id s10-20020a056a00194a00b00561a950c2e0mr10448808pfk.10.1664961950569;
        Wed, 05 Oct 2022 02:25:50 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-92.three.co.id. [180.214.232.92])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902d2c600b0017f36638010sm5633001plc.276.2022.10.05.02.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 02:25:50 -0700 (PDT)
Message-ID: <3f0417cf-a58d-a2bd-7a9a-1d4dabf89970@gmail.com>
Date:   Wed, 5 Oct 2022 16:25:39 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 01/39] Documentation/x86: Add CET description
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-2-rick.p.edgecombe@intel.com>
 <YzZlT7sO56TzXgNc@debian.me> <87v8p5f0mg.fsf@meer.lwn.net>
 <0eb358ac-068c-d025-07e3-80a3c51ef39c@gmail.com>
 <5832fa687e6da50697a7627d53453b728ed1b7b7.camel@intel.com>
 <Yz1KFj71T4Q4mFrg@hirez.programming.kicks-ass.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <Yz1KFj71T4Q4mFrg@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/5/22 16:10, Peter Zijlstra wrote:
> On Mon, Oct 03, 2022 at 04:56:10PM +0000, Edgecombe, Rick P wrote:
>> Thanks. Unless anyone has any objections
> 
> Well, I'll object. I still feel rst should burn in hell. Plain text FTW.
> 
> 

.txt maybe?

-- 
An old man doll... just what I always wanted! - Clara
