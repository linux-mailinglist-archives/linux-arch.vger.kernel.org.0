Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CE06E8EA4
	for <lists+linux-arch@lfdr.de>; Thu, 20 Apr 2023 11:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjDTJxr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Apr 2023 05:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbjDTJxZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Apr 2023 05:53:25 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076B52717;
        Thu, 20 Apr 2023 02:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1681983530; bh=+IEVt5W9F0gjxAaC4CllqBec7+yRAyjXDwEBBi0y8+M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=usEAZtEEU3n9mOTxx+ZUxBLWk99loHpiSBTFL9yhxw3KE9eW12LIzdg4670yCPuS1
         /52r1KjVe0+VITEjluDv8S7y8cExxm7e/cXx6BGMGxySXgX7SMOxrE/bCHaT15dBbi
         KK92eCmk6846WYZGlroUmJ//Rf5dxGPUFvZzn0uc=
Received: from [100.100.33.167] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 01FA2600D4;
        Thu, 20 Apr 2023 17:38:49 +0800 (CST)
Message-ID: <2e8d357d-e006-bda8-3711-dcbafbd4c53e@xen0n.name>
Date:   Thu, 20 Apr 2023 17:38:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] LoongArch: Make bounds-checking instructions useful
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>, Xi Ruoyao <xry111@xry111.site>
Cc:     loongarch@lists.linux.dev, WANG Xuerui <git@xen0n.name>,
        Eric Biederman <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230416173326.3995295-1-kernel@xen0n.name>
 <e593541e7995cc46359da3dd4eb3a69094e969e2.camel@xry111.site>
 <6ca642a9-62a6-00e5-39ac-f14ef36f6bdb@xen0n.name>
 <f54abfae989023fcfdabb4e9800a66847c357b85.camel@xry111.site>
 <CAAhV-H7zTjSsz=e+0r-9Z0KOF-Gxr-chXnVgWo+4eNA1ptWw1g@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H7zTjSsz=e+0r-9Z0KOF-Gxr-chXnVgWo+4eNA1ptWw1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023/4/20 16:36, Huacai Chen wrote:
> Hi, Xuerui,
> 
> I hope V2 can be applied cleanly without the patch series "LoongArch:
> Better backtraces", thanks.

I believe it's already the case (just try; I've moved the BADV printing 
for BCE into the better backtraces series before sending this).

I'm only waiting for comments from the other UAPI maintainers on the CC 
list.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

