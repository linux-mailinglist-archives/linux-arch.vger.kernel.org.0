Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DD6788ED9
	for <lists+linux-arch@lfdr.de>; Fri, 25 Aug 2023 20:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjHYSmH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Aug 2023 14:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjHYSlj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Aug 2023 14:41:39 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51A00CD2;
        Fri, 25 Aug 2023 11:41:37 -0700 (PDT)
Received: from [192.168.0.5] (71-212-112-68.tukw.qwest.net [71.212.112.68])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7763A2127C98;
        Fri, 25 Aug 2023 11:41:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7763A2127C98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692988896;
        bh=r4TNOTdwvr0jLYHJLt0g9pFNyHVSneTmcu12aApJMls=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CgVQ+RvETEOWpVRpx8KiKE6S7h1NeeymYBzRxdMaFA3TVUbKkkQk5+2saGc8Qj6zD
         H94BKZd9cf5DzxzyeGfp4KVVOJ76AlhCmMMn9UhKTAB4/baPsZEOZocCWujTCiz3Wa
         dsT+VvykH2pGZWcPD96moBVjOwyRNyYW7StxfslY=
Message-ID: <0909fb87-9370-4c59-b7ea-9ca673d456b3@linux.microsoft.com>
Date:   Fri, 25 Aug 2023 11:41:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-16-git-send-email-nunodasneves@linux.microsoft.com>
 <ZOeh-4pFgil54iyx@boqun-archlinux>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <ZOeh-4pFgil54iyx@boqun-archlinux>
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

On 8/24/2023 11:31 AM, Boqun Feng wrote:
> On Thu, Aug 17, 2023 at 03:01:51PM -0700, Nuno Das Neves wrote:
> [...]
>> +static long
>> +mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>> +{
>> +	switch (ioctl) {
>> +	case MSHV_CHECK_EXTENSION:
>> +		return mshv_ioctl_check_extension((void __user *)arg);
>> +	case MSHV_CREATE_PARTITION:
>> +		return mshv.create_partition((void __user *)arg);
>> +	case MSHV_CREATE_VTL:
>> +		return mshv.create_vtl((void __user *)arg);
>> +	}
>> +
> 
> Shouldn't we also have a MSHV_GET_API_VERSION ioctl similar as KVM? So
> that in the future when we change these ioctl interfaces or semantics,
> we can bump up the API version to avoid breaking userspace?
> 

Note that we contribute and maintain support for this driver in
Cloud Hypervisor, so we control both sides of this API - if we break
userspace we can fix it ourselves.

For now the MSHV_CHECK_EXTENSION ioctl is sufficient - we can pass it
MSHV_CAP_CORE_API_STABLE, and it will return 0 to indicate that the API
is not yet stable.

A version check may be useful in the future, but is not needed right now.

Thanks
Nuno Das Neves
