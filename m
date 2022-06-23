Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C82556FF4
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 03:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiFWBhj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 21:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiFWBhi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 21:37:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A151570E;
        Wed, 22 Jun 2022 18:37:36 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LT2rG1SKTzhXZY;
        Thu, 23 Jun 2022 09:35:26 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 09:37:33 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 23 Jun
 2022 09:37:33 +0800
Message-ID: <913e2f4a-ec70-d914-ce70-0cfea7d52921@huawei.com>
Date:   Thu, 23 Jun 2022 09:37:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 00/33] objtool: add base support for arm64
Content-Language: en-US
To:     Daniel Thompson <daniel.thompson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <live-patching@vger.kernel.org>,
        <jpoimboe@kernel.org>, <peterz@infradead.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <masahiroy@kernel.org>, <michal.lkml@markovi.net>,
        <ndesaulniers@google.com>, <mark.rutland@arm.com>,
        <pasha.tatashin@soleen.com>, <broonie@kernel.org>,
        <rmk+kernel@armlinux.org.uk>, <madvenka@linux.microsoft.com>,
        <christophe.leroy@csgroup.eu>
References: <20220622154920.95075-1-chenzhongjin@huawei.com>
 <20220622171946.mc3cd375fy4fou3b@maple.lan>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <20220622171946.mc3cd375fy4fou3b@maple.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 2022/6/23 1:19, Daniel Thompson wrote:
> On Wed, Jun 22, 2022 at 11:48:47PM +0800, Chen Zhongjin wrote:
>> This series enables objtool to start doing stack validation and orc
>> generation on arm64 kernel builds.
>>
>> Based on Julien's previous work(1)(2), Now I have finished most of work
>> for objtool enable on arm64. This series includes objtool part [1-13]
>> and arm64 support part [14-33], the second part is to make objtool run
>> correctly with no warning on arm64 so if necessary it can be taken apart
>> as two series.
>>
>> ORC generation feature is implemented but not used because we don't have
>> an unwinder_orc on arm64, now it only be used to check whether objtool
>> has correct validation.
>>
>> This series depends on (https://lkml.org/lkml/2022/6/22/463)
>> I moved some changes which work for all architectures to that series
>> because this one becomes too big now.
>> And it is rebased to tip/objtool/core branch.
> 
> What is the sha1 of the base?
> 
> With b4 and git am the patch series is derailing at patch 6 and I'm even
> after a bit of fixup (had to use rediff) I'm still getting a cascade of
> errors in later patches to decode.c .
> 
> 
> Daniel.
> .

Thanks for your review!

It seems I stupidly deleted something before sending the patch. I'm trying to
regenerate it and send another version.

Very sorry for that makes trouble, please try the next version later, thanks!

Best,
Chen

