Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E264477EF68
	for <lists+linux-arch@lfdr.de>; Thu, 17 Aug 2023 05:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347807AbjHQDPj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 23:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347825AbjHQDPc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 23:15:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BBB1724;
        Wed, 16 Aug 2023 20:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=P/kFyzCr/eSDaJkbY0OlCILEe1j9xWTLXn/yJLAYIu4=; b=A9+ZOyBLxgvkefgcCG3G+GbFOc
        t3Q4LPTtkkpyh0LBpbAFdc+3lhG3pcvB3Tuy2cTe9/M//iW+Sx1QS7+tpwHS9HCucIDpD/RDGCGIr
        FphyIapebkE7eEjeEnFtOi+9dwumQAvsQRYGjE0GEiZ5WBo53AxtXkFjlluHJQQSFYe1ZQ0mwCfpK
        6X/okD9sKE4Z8iWegd56l1SCJXl6wUSJ5Uk04klLzVcTy3SNTh8mgr2aL00kPfkoj1Td2N2/Azxck
        21ORjXTS2+GmCUfbeyQtLCC4mizooGziW6L1eBdD4Ta+hfKURTJGkPtTMCT5Ht16ny8Gi1C8JbRXm
        mdreectQ==;
Received: from [2601:1c2:980:9ec0::1a0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWTTi-000tOI-Mm; Thu, 17 Aug 2023 03:15:18 +0000
Message-ID: <86e329b1-c8d7-47bf-8be8-3326daf74eb5@infradead.org>
Date:   Wed, 16 Aug 2023 20:15:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] treewide: drop CONFIG_EMBEDDED
To:     20230816055010.31534-1-rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vgupta@kernel.org>,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        linux-openrisc@vger.kernel.org, linux-mips@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <38e1a01b-1e8b-7c66-bafc-fc5861f08da9@gmail.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <38e1a01b-1e8b-7c66-bafc-fc5861f08da9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Jesse,

On 8/16/23 15:45, Jesse Taube wrote:
> Hi, Randy
> 
>> diff -- a/init/Kconfig b/init/Kconfig
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -1790,14 +1790,6 @@ config DEBUG_RSEQ
>>
>>        If unsure, say N.
>>
>> -config EMBEDDED
>> -    bool "Embedded system"
>> -    select EXPERT
>> -    help
>> -      This option should be enabled if compiling the kernel for
>> -      an embedded system so certain expert options are available
>> -      for configuration.
> 
> Wouldn't removing this break many out of tree configs?

I'm not familiar with out-of-tree configs.
Do you have some examples of some that use CONFIG_EMBEDDED?
(not distros)

> Should there be a warning here to update change it instead of removal?

kconfig doesn't have a warning mechanism AFAIK.
Do you have an idea of how this would work?

We could make a smaller change to init/Kconfig, like so:

 config EMBEDDED
-	bool "Embedded system"
+	bool "Embedded system (DEPRECATED)"
 	select EXPERT
 	help
-	  This option should be enabled if compiling the kernel for
-	  an embedded system so certain expert options are available
-	  for configuration.
+	  This option is being removed after Linux 6.6.
+	  Use EXPERT instead of EMBEDDED.

but there is no way to produce a warning message. I.e., even with this
change, the message will probably be overlooked.

---
~Randy

