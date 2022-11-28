Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A6863A0D7
	for <lists+linux-arch@lfdr.de>; Mon, 28 Nov 2022 06:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiK1FrP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Nov 2022 00:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiK1FrP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Nov 2022 00:47:15 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5693F65BA;
        Sun, 27 Nov 2022 21:47:14 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 130so9424975pfu.8;
        Sun, 27 Nov 2022 21:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=clF2yN6A6iGTuwA3DES6a8mecm0VV0tg9cwaWgrqg4Y=;
        b=dE6HmyOP0M5nVfXXS24HyNDQ+y26F7nAFaBGZ9e2Mtvr2qwotgdHiYWpLAOzAEri+t
         NLpORagnXvw930gYpb2fTmkAV+f51DEpPPHD7QPk/sZxY5Tk/ClQj637DKK08qggIDLW
         dIuyVv0zLoXbGsumsr1CfdmiprN8sKSTxmFO/c1oRZXhN2pSYzZx5cmC+0402OtV48Em
         bR4roYRvsKc6hruGl9LCAKfRCAC609uamf+eCybtl5HkC1wTUIA2fIx9kMEsNEc8trIr
         cGbcP5d8OjWMIlIsv+npch1XkGGkycuUVrDefYHhauh84MwJ77lbbIIy7+DgyV4hmXPb
         QXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=clF2yN6A6iGTuwA3DES6a8mecm0VV0tg9cwaWgrqg4Y=;
        b=e+fDNT39uGGX8ouhelbcnjY0dxKAQXqt2dZGgAbeLNYIRrvdUZJIJH6KLQSgjEZD1b
         vexxYHqSpnT2/7hq8YpynNGiLsvLDmZf2vw21WexPm+RNDGnx80iG4nY776uQWtGohvj
         VbDHHQYxepDdYaKS2o4DRcfXE6i/UWFbb2NYk36L1qWeOES3Cpv5MzJyeUGLOPitvt3z
         LE7p642JKnsCTkqOk5Vzih0MV/s+t71wvWrG2IdC8TA1YN6FaQzjnXbAw8M4Dj8rCvN+
         O5DJEYgJHVSy8Kpp8kVE8N6qZkvD3r8aL5tAjfq0I2NQF2QQNQvlr47gEf+/xdjdhtKu
         4Fgw==
X-Gm-Message-State: ANoB5pl9k1PeV6hrwiB/8+5YQBKpQ5/+xh6spahfj+jb9gFcTCowzC6M
        ZyXydRDm6gZulnAWpszJ2Hc=
X-Google-Smtp-Source: AA0mqf67ZMWERK2VwdcyNZwgNvK2LUVZ/GRAWUyruH0SAA/dcYbftyaPvpTc8uYdy1HcWJymWUh5/w==
X-Received: by 2002:a63:d04f:0:b0:46e:c41c:e4bf with SMTP id s15-20020a63d04f000000b0046ec41ce4bfmr26257003pgi.123.1669614433613;
        Sun, 27 Nov 2022 21:47:13 -0800 (PST)
Received: from ?IPV6:2404:f801:10:463:955f:7dcb:f571:942c? ([2404:f801:9000:1a:9b8:7dcb:f571:942c])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090322d000b00186e34524e3sm7806256plg.136.2022.11.27.21.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 21:47:12 -0800 (PST)
Message-ID: <0d928bdf-769f-8eca-2e3e-5d6e438ef048@gmail.com>
Date:   Mon, 28 Nov 2022 13:47:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCH V2 16/18] x86/sev: Initialize #HV doorbell and handle
 interrupt requests
Content-Language: en-US
To:     Christophe de Dinechin <dinechin@redhat.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-17-ltykernel@gmail.com> <m2ilj3kr19.fsf@redhat.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <m2ilj3kr19.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/25/2022 7:49 PM, Christophe de Dinechin wrote:
>> +void check_hv_pending(struct pt_regs *regs)
> This looks like two functions, one with regs == NULL and one with regs,
> different internal logic, different call sites. Would you consider splitting
> into two?
>

Good suggestion. Will update in the next version.

