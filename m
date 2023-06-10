Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1778672AE92
	for <lists+linux-arch@lfdr.de>; Sat, 10 Jun 2023 22:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjFJUNV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Jun 2023 16:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFJUNU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Jun 2023 16:13:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455CA359D;
        Sat, 10 Jun 2023 13:13:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686427997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2FyW3Bj3MP4r2QbMriRspWC1T3TG2cIZbpm8o1sYXRk=;
        b=Bd6rcV9NAKZ2jF9T8IY/r60E4T8w90YHhU5xFpw/hpWHfXb8L6JiuDXY0t79Yll+2GT6qE
        xrQyfEHRFmUxuDwx1/hyEMammkYISdlkOp8umKeLO+o4AnucWOKnN3HM0OxQQL/XA0ywIy
        jHqvlI6q6CItsjeO85N9m0vwdlI0qw4BBxATVqzRnrzmnuXkZGICP3+ltYVrg+XNfQ8PH1
        ZntGRksKEHGrc3g3thOpY0E4eqXRzpz0bQI1NqI/3iDCzmd14sewUC7kzvRe7xLNc7k3EH
        LI7pUFpw5cBoVrnoMRc/G/yBYTw2YrVP6uWDa4mT9GS4MqLzrE6VkQ91ePn82w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686427997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2FyW3Bj3MP4r2QbMriRspWC1T3TG2cIZbpm8o1sYXRk=;
        b=bgPUpEic0mpyby3BGyAvEpiW4XSnGc6In+X8PMucBYAVIRaPTCmQlzaXQV9yZA55ZBey2P
        6Kr948u6T/TlPVBw==
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        ldufour@linux.ibm.com, bp@alien8.de, dave.hansen@linux.intel.com,
        mingo@redhat.com, x86@kernel.org
Subject: Re: [PATCH 6/9] cpu/SMT: Allow enabling partial SMT states via sysfs
In-Reply-To: <87r0qj84fr.ffs@tglx>
References: <20230524155630.794584-1-mpe@ellerman.id.au>
 <20230524155630.794584-6-mpe@ellerman.id.au> <87r0qj84fr.ffs@tglx>
Date:   Sat, 10 Jun 2023 22:13:17 +0200
Message-ID: <87o7ln849u.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 10 2023 at 22:09, Thomas Gleixner wrote:

> On Thu, May 25 2023 at 01:56, Michael Ellerman wrote:
>> There is a hook which allows arch code to control how many threads per
>
> Can you please write out architecture in changelogs and comments?
>
> I know 'arch' is commonly used but while my brain parser tolerates
> 'arch_' prefixes it raises an exception on 'arch' in prose as 'arch' is
> a regular word with a completely different meaning. Changelogs and
> comments are not space constraint.
>
>> @@ -2505,20 +2505,38 @@ __store_smt_control(struct device *dev, struct device_attribute *attr,
>>  	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
>>  		return -ENODEV;
>>  
>> -	if (sysfs_streq(buf, "on"))
>> +	if (sysfs_streq(buf, "on")) {
>>  		ctrlval = CPU_SMT_ENABLED;
>> -	else if (sysfs_streq(buf, "off"))
>> +		num_threads = cpu_smt_max_threads;
>> +	} else if (sysfs_streq(buf, "off")) {
>>  		ctrlval = CPU_SMT_DISABLED;
>> -	else if (sysfs_streq(buf, "forceoff"))
>> +		num_threads = 1;
>> +	} else if (sysfs_streq(buf, "forceoff")) {
>>  		ctrlval = CPU_SMT_FORCE_DISABLED;
>> -	else
>> +		num_threads = 1;
>> +	} else if (kstrtoint(buf, 10, &num_threads) == 0) {
>> +		if (num_threads == 1)
>> +			ctrlval = CPU_SMT_DISABLED;
>> +		else if (num_threads > 1 && topology_smt_threads_supported(num_threads))

Why does this not simply check cpu_smt_max_threads?

		else if (num_threads > 1 && num_threads <= cpu_smt_max_threads)

cpu_smt_max_threads should have been established already, no?

Thanks,

        tglx
