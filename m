Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC6277D5BB
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 00:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbjHOV6G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Aug 2023 17:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbjHOV5e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Aug 2023 17:57:34 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3989D1FDC;
        Tue, 15 Aug 2023 14:57:33 -0700 (PDT)
Received: from [192.168.0.5] (71-212-112-68.tukw.qwest.net [71.212.112.68])
        by linux.microsoft.com (Postfix) with ESMTPSA id 39D36211F5F1;
        Tue, 15 Aug 2023 14:57:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 39D36211F5F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692136652;
        bh=qTgOWQ6rlqLWDIt+xECvqDYP7UBleUA7wutt7s/+/aE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=q4UFBAWAnqP5SnzURd49DQE4tzTZO/DcFJYzj0OsMipnQDqVCO57h7wx8lbBPLaOp
         90zwqvRX2aF34zoEjM5cbHoqzhl8InV9dvSSl1KWHEdCigoq0gUs0KoKc7KhyRa1Aj
         ZIjGXS8ae3qqfch/jagch3PjKYVp/ooO3ywZg35I=
Message-ID: <9ff9b099-9c6b-4636-8bbc-1825f132c712@linux.microsoft.com>
Date:   Tue, 15 Aug 2023 14:57:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] mshyperv: Introduce hv_get_hypervisor_version
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-3-git-send-email-nunodasneves@linux.microsoft.com>
 <ZMrpSJvedrLqg6xK@liuwe-devbox-debian-v2>
Content-Language: en-US
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <ZMrpSJvedrLqg6xK@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/2/2023 4:39 PM, Wei Liu wrote:
> On Thu, Jul 27, 2023 at 12:54:37PM -0700, Nuno Das Neves wrote:
>> x86_64 and arm64 implementations to get the hypervisor version
>> information.
>> Also introduce hv_hypervisor_version_info structure to simplify parsing
>> the fields.
>> Replace the existing parsing when printing the version numbers.
> 
> The line wrapping looks odd. When you resend, please fix it. If you
> meant to use multiple paragraphs, please insert a blank line between
> them.
> 

Thanks, I'll fix it.

