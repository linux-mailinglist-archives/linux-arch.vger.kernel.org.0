Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B1C77D5C1
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 00:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbjHOWFD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Aug 2023 18:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238698AbjHOWEe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Aug 2023 18:04:34 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E55391FEC;
        Tue, 15 Aug 2023 15:04:33 -0700 (PDT)
Received: from [192.168.0.5] (71-212-112-68.tukw.qwest.net [71.212.112.68])
        by linux.microsoft.com (Postfix) with ESMTPSA id D3EF6211F5F2;
        Tue, 15 Aug 2023 15:04:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D3EF6211F5F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692137073;
        bh=ZEHRtmD5N4HTql+UiCFlYekUgyF4BWm0VvzhV82SRN0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SFIuoHSLj1VV/9AYugSnRc/MkZdJpJh3pKm9QzPJZ9Y82LTeDtKNBvwgEiCBS5xpl
         6ErqlGWT4kVlijHahPaLgxGzURL6e5jVy9cXzqpWDYhdbSXSWuEzhYMlkM+xddANhT
         MpTaZ49LM8nABke03H4jvxc7AajZtfMckpA/8D70=
Message-ID: <73250561-fb75-47bd-a41d-0dc3d8dc9ddf@linux.microsoft.com>
Date:   Tue, 15 Aug 2023 15:04:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] hyperv: Move hv_connection_id to hyperv-tlfs
Content-Language: en-US
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
 <1690487690-2428-6-git-send-email-nunodasneves@linux.microsoft.com>
 <ZMrs/BgDzxlLL0VX@liuwe-devbox-debian-v2>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <ZMrs/BgDzxlLL0VX@liuwe-devbox-debian-v2>
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

On 8/2/2023 4:55 PM, Wei Liu wrote:
> On Thu, Jul 27, 2023 at 12:54:40PM -0700, Nuno Das Neves wrote:
>> This structure should be in hyperv-tlfs.h anyway, since it is part of
>> the TLFS document.
> 
> Missing blank line here.
> 
Thanks, will fix.

>> The definition conflicts with one added in hvgdk.h as part of the mshv
>> driver so must be moved to hyperv-tlfs.h.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  include/asm-generic/hyperv-tlfs.h | 9 +++++++++
>>  include/linux/hyperv.h            | 9 ---------
>>  2 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
>> index 373f26efa18a..8fc5e5a9d7cb 100644
>> --- a/include/asm-generic/hyperv-tlfs.h
>> +++ b/include/asm-generic/hyperv-tlfs.h
>> @@ -845,4 +845,13 @@ struct hv_mmio_write_input {
>>  	u8 data[HV_HYPERCALL_MMIO_MAX_DATA_LENGTH];
>>  } __packed;
>>  
>> +/* Define connection identifier type. */
>> +union hv_connection_id {
>> +	u32 asu32;
>> +	struct {
>> +		u32 id:24;
>> +		u32 reserved:8;
>> +	} u;
>> +};
>> +
> 
> Missing __packed here, but since this is already aligned it probably
> doesn't matter much.
> Yes, it should be fine without __packed.

>>  #endif
>> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
>> index bfbc37ce223b..f90de5abcd50 100644
>> --- a/include/linux/hyperv.h
>> +++ b/include/linux/hyperv.h
>> @@ -748,15 +748,6 @@ struct vmbus_close_msg {
>>  	struct vmbus_channel_close_channel msg;
>>  };
>>  
>> -/* Define connection identifier type. */
>> -union hv_connection_id {
>> -	u32 asu32;
>> -	struct {
>> -		u32 id:24;
>> -		u32 reserved:8;
>> -	} u;
>> -};
>> -
>>  enum vmbus_device_type {
>>  	HV_IDE = 0,
>>  	HV_SCSI,
>> -- 
>> 2.25.1
>>

