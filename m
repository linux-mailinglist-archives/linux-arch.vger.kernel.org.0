Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BB3788EA3
	for <lists+linux-arch@lfdr.de>; Fri, 25 Aug 2023 20:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjHYSZV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Aug 2023 14:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjHYSZC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Aug 2023 14:25:02 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D65B6E50;
        Fri, 25 Aug 2023 11:24:59 -0700 (PDT)
Received: from [192.168.0.5] (71-212-112-68.tukw.qwest.net [71.212.112.68])
        by linux.microsoft.com (Postfix) with ESMTPSA id D00DA2127C95;
        Fri, 25 Aug 2023 11:24:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D00DA2127C95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692987899;
        bh=lTiAq6TIQlz3/KRzBrYOW9Zloaa6S2j8QsR1OWQ9nd0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O7+HQDi40dbcU5ZJ+REsZOWEZbODS6aqRVj4DMw9c6KTpW6MGAoCJiEkoiHCN9+lb
         qeO/sDXHDMnr3G3VhGWUbUBoBwRvv009PLONJU70BqfDsHZJ+EUTSjer4YwBIGwRdZ
         jJPkTnenGtlRUjYJeGFRyc2zXJLb3eQBXaQU9Y1A=
Message-ID: <c4482a6a-aed0-4750-aa1b-421f0e541cfa@linux.microsoft.com>
Date:   Fri, 25 Aug 2023 11:24:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] uapi: hyperv: Add mshv driver headers hvhdk.h,
 hvhdk_mini.h, hvgdk.h, hvgdk_mini.h
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>, Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
        catalin.marinas@arm.com
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-14-git-send-email-nunodasneves@linux.microsoft.com>
 <ZN6m2gVmtVStuEfA@liuwe-devbox-debian-v2> <2023081923-crown-cake-79f7@gregkh>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <2023081923-crown-cake-79f7@gregkh>
Content-Type: text/plain; charset=UTF-8
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

On 8/19/2023 3:26 AM, Greg KH wrote:
> 
> My "strong" opinion is the one kernel development rule that we have,
> "you can not break userspace".  So, if you change these
> values/structures/whatever in the future, and userspace tools break,
> that's not ok and the changes have to be reverted.
> 
> If you can control both sides of the API here (with open tools that you
> can guarantee everyone will always update to), then yes, you can change
> the api in the future.
> 

This is true for us - we contribute and maintain support for this driver
in Cloud Hypervisor[1], an open source VMM.

We also do a check of the hypervisor version when the driver loads, and
refuse to proceed if it is running on an incompatible hypervisor.

Thanks,
Nuno Das Neves


[1] https://github.com/cloud-hypervisor/cloud-hypervisor

