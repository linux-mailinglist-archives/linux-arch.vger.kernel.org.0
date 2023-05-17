Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25EE70637F
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 11:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjEQJCk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 05:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjEQJCY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 05:02:24 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC1F30E0;
        Wed, 17 May 2023 02:02:03 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64ab2a37812so11523573b3a.1;
        Wed, 17 May 2023 02:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684314123; x=1686906123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ph7FWotnDHyNH43Suo9o026I5GBhoRCi6trqJm+ae1c=;
        b=cOn7sW93YxROwtygiZ4kd6HC6BbzEHtija5wSUXNqYIudX5SCymwnx4qX3kwMKrjWV
         90e27La7ebSJzffNnJsKKHey7cKsPV/kors2tLfdFYziBd0nPtoHMafZBFsQiQyKpLhh
         FlktAOsEqWN7I3T4kvxc51w9EjkSrpw5EWcZI/pk5PUJWkKwYj65dnxR+39jZ0kg0m38
         AkBEe7+TelBuXq8v+ZNCnqZSpJAax9mH3MTWDpBe78F3DFEW3efPAKuR8GwnOQZNQvL4
         Q8tS5ZooefJN3S5lCYtSZmvqD6TAzWE6OOftQuMwRuuWnZxEIo30Y/0WKIs3Xc/oEgf8
         gr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684314123; x=1686906123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ph7FWotnDHyNH43Suo9o026I5GBhoRCi6trqJm+ae1c=;
        b=bp2ZC+lYCeShFRvM4cwkWcqT/ZkWXNC4Pj/Ucy7lYMBjg1j2HX6WsM1vt07b+kKq6R
         MLycK9TrQVLEtEJbevjUvfOfJVn3R21iJP4+Hj+xJJZbzP3mMQKv0JiIVhmlL6bENa+h
         gvDl9d3JU1lVnRQ202GPspGaRnIssDPonEpWcAlTYZCQjH41dimKOcbGHWE51nN22SSd
         SjRMICLk0+K3WbSjfyqj7TmeDoZTEbc+4aaNRLmD9zgfhFXIBKa0oKoFCSl8UQfdqCom
         ky23r00iESoDL/7mhX6K+gD+Yt1N/18kKoWU1wW+KEcIrcYz/5WUT4Gzkm9y5nF+pVHi
         sUFA==
X-Gm-Message-State: AC+VfDxv8bfDRqB/lq5Rz/jqBupuQj/AL+XR6HKaeM38me2JTtqGFuyq
        +/zPyIn98xwpnxCu3sDvgbA=
X-Google-Smtp-Source: ACHHUZ63hS1/S/jzGaGnpkvjna7RhS7G2JWLtso6RdQPEeBMDByM66294yz5+hFQTOQZz07Cn9oEkg==
X-Received: by 2002:a17:90b:4b0e:b0:250:648b:781d with SMTP id lx14-20020a17090b4b0e00b00250648b781dmr1763729pjb.23.1684314122885;
        Wed, 17 May 2023 02:02:02 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id l14-20020a17090a384e00b00250d670306esm1076450pjf.35.2023.05.17.02.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 02:02:02 -0700 (PDT)
Message-ID: <e255cc80-a232-d66c-5f9b-9db179d33951@gmail.com>
Date:   Wed, 17 May 2023 17:01:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH V6 01/14] x86/sev: Add a #HV exception handler
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, ashish.kalra@amd.com,
        srutherford@google.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, pawan.kumar.gupta@linux.intel.com,
        adrian.hunter@intel.com, daniel.sneddon@linux.intel.com,
        alexander.shishkin@linux.intel.com, sandipan.das@amd.com,
        ray.huang@amd.com, brijesh.singh@amd.com, michael.roth@amd.com,
        thomas.lendacky@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com, pangupta@amd.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20230515165917.1306922-1-ltykernel@gmail.com>
 <20230515165917.1306922-2-ltykernel@gmail.com>
 <20230516093010.GC2587705@hirez.programming.kicks-ass.net>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20230516093010.GC2587705@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/16/2023 5:30 PM, Peter Zijlstra wrote:
> On Mon, May 15, 2023 at 12:59:03PM -0400, Tianyu Lan wrote:
>> From: Tianyu Lan<tiala@microsoft.com>
>>
>> Add a #HV exception handler that uses IST stack.
>>
> Urgh.. that is entirely insufficient. Like it doesn't even begin to
> start to cover things.
> 
> The whole existing VC IST stack abuse is already a nightmare and you're
> duplicating that.. without any explanation for why this would be needed
> and how it is correct.
> 
> Please try again.

Hi Peter:
	Thanks for your review. Will add more explanation in the next version.
