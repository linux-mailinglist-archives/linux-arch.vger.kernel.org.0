Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CC9564C3C
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 05:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiGDD5f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Jul 2022 23:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiGDD5e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Jul 2022 23:57:34 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FD01A4;
        Sun,  3 Jul 2022 20:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1656907050; bh=nEFAaimDHQ9+9OzaA/ZB4ZaY0ZaBzpTQo6pKly4wWzE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=wWuMthucJbzktwB/xbORvGK5uNDweBclk0LJ/uzlpsQK+o4fTm4aPZIJnR97asuj4
         se5k8kontPi/E0XftB0voNn3GTQzXY3ltXkJ/jG6SnX7/pCZdcQPZQudGzRHp0TKsU
         VuBFExTLic5XZTBaNkmMj2c6SHB23jyZof9/3I0I=
Received: from [100.100.57.190] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 32DAA60091;
        Mon,  4 Jul 2022 11:57:29 +0800 (CST)
Message-ID: <aa74c870-e4e9-a2aa-ddae-91cce62a3fe5@xen0n.name>
Date:   Mon, 4 Jul 2022 11:57:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:104.0)
 Gecko/20100101 Thunderbird/104.0a1
Subject: Re: [PATCH 12/14] loongarch: drop definition of PGD_ORDER
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dinh Nguyen <dinguyen@kernel.org>, Guo Ren <guoren@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        WANG Xuerui <kernel@xen0n.name>, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        loongarch@lists.linux.dev
References: <20220703141203.147893-1-rppt@kernel.org>
 <20220703141203.147893-13-rppt@kernel.org>
 <YsIBFVcdJSQNK+pV@casper.infradead.org>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <YsIBFVcdJSQNK+pV@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 2022/7/4 04:50, Matthew Wilcox wrote:
> On Sun, Jul 03, 2022 at 05:12:01PM +0300, Mike Rapoport wrote:
>> +++ b/arch/loongarch/kernel/asm-offsets.c
>> @@ -190,7 +190,6 @@ void output_mm_defines(void)
>>   #endif
>>   	DEFINE(_PTE_T_LOG2, PTE_T_LOG2);
>>   	BLANK();
>> -	DEFINE(_PGD_ORDER, PGD_ORDER);
>>   	BLANK();
>>   	DEFINE(_PMD_SHIFT, PMD_SHIFT);
>>   	DEFINE(_PGDIR_SHIFT, PGDIR_SHIFT);
> Should probably also drop one of these BLANK() lines too?
>
Agreed; IMO the blank lines can and should be removed because the 
surrounding lines are also mm definitions.
