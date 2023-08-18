Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A65D7815E0
	for <lists+linux-arch@lfdr.de>; Sat, 19 Aug 2023 01:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242851AbjHRXpK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 19:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242300AbjHRXon (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 19:44:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BEE2135;
        Fri, 18 Aug 2023 16:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=xTd+xM15uwaYqGAW/S8CZDkcwvuJ3aJIIjx1MPGNF/Y=; b=pZH/ksRwnPq3maIwYAlJC3Rrrr
        9sXlHg5rZOuCTKksS/zIoMTj4CYgiei2BSHr/Fmq4d5o6u6K44iFq95QRQnAeXh21SPlKB1dSqI9S
        Cfts7MiOtQtejm51Kqr727hN42qMODja2NIagNNWPITLUN3zgCX6JPHkj/KLLfXzJl6lnRj2IQpX0
        rdlY37izaBlOJXXS/VdrrvoBUDNRoF1KuxWjFO1MPDhsEqGcrcCV503FRIC+zvjs3tCc/aw4OtNDw
        1CgyBaH6pumLMmkbfGn+hR53qU8NQHPiWTB5c7oduD3LBzu4IRjjLr3T37jzgVW5PH9+G1oKRWkqj
        I69daqCw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qX98o-00ABNX-07;
        Fri, 18 Aug 2023 23:44:30 +0000
Message-ID: <78a802c5-3f0d-e199-d974-e586c00180eb@infradead.org>
Date:   Fri, 18 Aug 2023 16:44:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] treewide: drop CONFIG_EMBEDDED
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
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
 <86e329b1-c8d7-47bf-8be8-3326daf74eb5@infradead.org>
In-Reply-To: <86e329b1-c8d7-47bf-8be8-3326daf74eb5@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Jesse,

I replied to your comment a few days ago, but for some reason
your email to me contains:
Reply-To: 20230816055010.31534-1-rdunlap@infradead.org
so it wasn't sent directly to you.

My former reply is below.

On 8/16/23 20:15, Randy Dunlap wrote:
> Hi Jesse,
> 
> On 8/16/23 15:45, Jesse Taube wrote:
>> Hi, Randy
>>
>>> diff -- a/init/Kconfig b/init/Kconfig
>>> --- a/init/Kconfig
>>> +++ b/init/Kconfig
>>> @@ -1790,14 +1790,6 @@ config DEBUG_RSEQ
>>>
>>>         If unsure, say N.
>>>
>>> -config EMBEDDED
>>> -    bool "Embedded system"
>>> -    select EXPERT
>>> -    help
>>> -      This option should be enabled if compiling the kernel for
>>> -      an embedded system so certain expert options are available
>>> -      for configuration.
>>
>> Wouldn't removing this break many out of tree configs?
> 
> I'm not familiar with out-of-tree configs.
> Do you have some examples of some that use CONFIG_EMBEDDED?
> (not distros)
> 
>> Should there be a warning here to update change it instead of removal?
> 
> kconfig doesn't have a warning mechanism AFAIK.
> Do you have an idea of how this would work?
> 
> We could make a smaller change to init/Kconfig, like so:
> 
>  config EMBEDDED
> -	bool "Embedded system"
> +	bool "Embedded system (DEPRECATED)"
>  	select EXPERT
>  	help
> -	  This option should be enabled if compiling the kernel for
> -	  an embedded system so certain expert options are available
> -	  for configuration.
> +	  This option is being removed after Linux 6.6.
> +	  Use EXPERT instead of EMBEDDED.
> 
> but there is no way to produce a warning message. I.e., even with this
> change, the message will probably be overlooked.
> 
> ---
> ~Randy

-- 
~Randy
