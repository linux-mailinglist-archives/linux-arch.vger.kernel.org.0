Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895137C611E
	for <lists+linux-arch@lfdr.de>; Thu, 12 Oct 2023 01:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjJKXce (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Oct 2023 19:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbjJKXcd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Oct 2023 19:32:33 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFC6EA9;
        Wed, 11 Oct 2023 16:32:31 -0700 (PDT)
Received: from [10.0.0.178] (c-76-135-56-23.hsd1.wa.comcast.net [76.135.56.23])
        by linux.microsoft.com (Postfix) with ESMTPSA id 80D9A20B74C0;
        Wed, 11 Oct 2023 16:32:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80D9A20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697067151;
        bh=4Hm83xIHy0uJKbXFIfT/CbbMnnFeszXXVJIu6LMsrrc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HbmZaTJobUZ3XDNnfzWrOkOnKOlVq7XoAVl3UI/c580uOL9uoPFUxcnZuVT3fewhn
         MXLwG6epTJtrZimHm5s+iWvkP0Fg8yDx8+vNEv6oZP9kQtXGr8o1hUn8iNFBP/u0Zl
         BGEIS0wv5i1LokehZ8ktTWZ9RlZuxQuFcrCkNMh4=
Message-ID: <0f2df9e8-8145-4749-893c-e256820bb90f@linux.microsoft.com>
Date:   Wed, 11 Oct 2023 16:32:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/15] asm-generic: hyperv: Use new Hyper-V headers
 conditionally.
To:     Alex Ionescu <aionescu@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        gregkh@linuxfoundation.org, haiyangz@microsoft.com,
        decui@microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
        catalin.marinas@arm.com
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-15-git-send-email-nunodasneves@linux.microsoft.com>
 <CAJ-90NKJ=FViuuy2MyA-8S1j9Lsia8bR-ytZuAr=pOPuAiO0VQ@mail.gmail.com>
 <749f477a-1e7a-495e-bea1-e3abe8da7fb9@linux.microsoft.com>
 <CAJ-90NL8S5xnJbiwCHAGs4QeiJ3DHUL0Obi1snqsTDJEpQRnsg@mail.gmail.com>
Content-Language: en-US
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <CAJ-90NL8S5xnJbiwCHAGs4QeiJ3DHUL0Obi1snqsTDJEpQRnsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/5/2023 12:52 PM, Alex Ionescu wrote:
>>> 3) Truly making hypertv-tlfs the "documented" header, and then > removing any duplication from HDK so that it remains the
>>> "undocumented" header file. In this manner, one would include
>>> hyperv-tlfs to use the stable ABI, and they would include HDK (which
>>> would include hyperv-tlfs) to use the unstable+stable ABI.
>>
>> hyperv-tlfs.h is remaining the "documented" header.
>>
>> But, we can't make the HDK header depend on hyperv-tlfs.h, for 2 primary
>> reasons:
>> 1. We need to put the new HDK headers in uapi so that we can use them in
>> our IOCTL interface. As a result, we can't include hyperv-tlfs.h (unless
>> we put it in uapi as well).
>> 2. The HDK headers not only duplicate, but also MODIFY some structures
>> in hyperv-tlfs.h. e.g., The struct is in hyperv-tlfs.h, but a particular
>> field or bitfield is not.
> 
> #2 was something I was worried about. Do you know if the
> standards/docs team is planning on updating the TLFS at some point
> with updates on their end? At which point I'd assume you'd be OK with
> patches to add them to hyperv-tlfs.h
> 

I don't know the current plans for updating the TLFS. But yes, assuming
a new TLFS doc has something that is needed in the kernel, hyperv-tlfs.h
would be updated to support that.

Thanks,
Nuno
