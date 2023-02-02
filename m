Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522E568803E
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 15:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjBBOgg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 09:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjBBOgf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 09:36:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BDEB46F;
        Thu,  2 Feb 2023 06:36:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC667B8265E;
        Thu,  2 Feb 2023 14:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04285C433D2;
        Thu,  2 Feb 2023 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675348592;
        bh=PUTKwu61nx4E8yIO29kUBc+gTUgWoPwlBHwWaYyw/p4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=g2GblDkaciicIjaFVbzvKrsNEdniwR07xXkNTgWhLkHXVdbb1P9YCKIFJWEWlxwV4
         diWLV0Xk3kK+cGrjoHFNySYUc1H5kO9KA58YVbjrcy8RglR76/M2gz+3ctU0QCxl31
         YTO4rTJoiATsTRBe8C5AUFnkDI8x5n7RCDuHXlmoiaMgJ6x5Jr8UFUl144hdgTjsu8
         idB5XuEoivdovE86aYffpwccZLWnTHbH4kxbZdBIq+A4VtlKquUlZvkSc4GRhJsfli
         yoVA4MW2ggKd44WzR8GrL0bv8k7A33usqVREPWe/LaNEmMhW+jdcHgjBNtvAk9Ms7i
         WS1njy1lUNw1A==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        liaochang1@huawei.com, linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Bjorn Topel <bjorn.topel@gmail.com>
Subject: Re: [PATCH] riscv: kprobe: Fixup misaligned load text
In-Reply-To: <5C373F4A-983E-4ACA-AAB0-54E629D5F501@jrtc27.com>
References: <20230201064608.3486136-1-guoren@kernel.org>
 <87tu05pvur.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTSj12E9+peMF0rNY_psGDyEG5BbMY6V-s4dK0FpkCC9Yw@mail.gmail.com>
 <87cz6s75ze.fsf@all.your.base.are.belong.to.us>
 <5C373F4A-983E-4ACA-AAB0-54E629D5F501@jrtc27.com>
Date:   Thu, 02 Feb 2023 15:36:29 +0100
Message-ID: <878rhgrv6a.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Jessica Clarke <jrtc27@jrtc27.com> writes:

>> +	p->opcode = *insn++;
>> +	if (GET_INSN_LENGTH(p->opcode) == 4)
>> +		p->opcode |= *insn << 16;
>
> *insn gets promoted to int not unsigned so this is UB if bit 15 is set.

Ugh. Good catch! I guess we can't get rid of *that* explicit cast to
kprobe_opcode_t here...
