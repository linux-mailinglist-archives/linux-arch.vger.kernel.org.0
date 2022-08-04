Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9452158A30C
	for <lists+linux-arch@lfdr.de>; Fri,  5 Aug 2022 00:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbiHDWGa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Aug 2022 18:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbiHDWG3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Aug 2022 18:06:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EFA286FB;
        Thu,  4 Aug 2022 15:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33679B82757;
        Thu,  4 Aug 2022 22:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912BDC433D6;
        Thu,  4 Aug 2022 22:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659650786;
        bh=oPo+trFJwGzdnE753WffpO/1jwPCCYWeSZJO0oqEqaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NcBNpvjQO4/Ba3ZoxMKk9AdLkBatj56K2n1wPO6zomZqV4AZDU6bq5rqpISraScot
         uKxeJnjtNFapCSqQSw3OKOWl4oOdCUCrQsD1IdrYPzyMbCVZTlWg3bowSmcdvbizpk
         2wOEv3ebaASWRrlZBHnrTJXmnsrTmwblr5m7yP6g3vcMBDyxNeoRFqO7Nr7uYAET2E
         bOGM4vyTASTSoGGYkQQvXQk7Z4I0mH9oxyrLDgMAgfKgFS/6BayLTaU5ZesEJzaepB
         TOTt7Rm1kP8g9xRoFCp621d7aQiHNWL0xqZqzBUB3w+bb0D1JPB59N3QOFRaeHbo0U
         7stLSHcamX1PQ==
Date:   Thu, 4 Aug 2022 15:06:23 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mbenes@suse.cz
Subject: Re: [PATCH] Revert "x86/unwind/orc: Don't skip the first frame for
 inactive tasks"
Message-ID: <20220804220623.a2s7ucblryudm63m@treble>
References: <20220727031506.59322-1-chenzhongjin@huawei.com>
 <20220804045518.bfhe3rxhpkxzn4hk@treble>
 <5ee1dfb5-fa70-d412-43c2-3e90ee057eec@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ee1dfb5-fa70-d412-43c2-3e90ee057eec@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 04, 2022 at 03:27:39PM +0800, Chen Zhongjin wrote:
> I believe disassemble show_stack in vmlinux and if we have:
> 
>     push   %rbp
> 
>     mov    %rsp,%rbp
> 
>     ... (no regs pushed to stack)
> 
>     callq  <show_trace_log_lvl>
> 
> This can be reproduced.

Weird, that's what I have.  This is GCC 12.1.

ffffffff81056de0 <show_stack>:
ffffffff81056de0:	e8 0b 43 05 00       	call   ffffffff810ab0f0 <__fentry__>
ffffffff81056de5:	55                   	push   %rbp
ffffffff81056de6:	48 83 05 b2 0f c9 02 01 	addq   $0x1,0x2c90fb2(%rip)        # ffffffff83ce7da0 <__gcov0.show_stack>
ffffffff81056dee:	48 89 e5             	mov    %rsp,%rbp
ffffffff81056df1:	48 85 ff             	test   %rdi,%rdi
ffffffff81056df4:	74 41                	je     ffffffff81056e37 <show_stack+0x57>
ffffffff81056df6:	48 85 f6             	test   %rsi,%rsi
ffffffff81056df9:	0f 85 c2 24 15 01    	jne    ffffffff821a92c1 <show_stack.cold+0xd>
ffffffff81056dff:	65 48 8b 04 25 c0 bd 01 00 	mov    %gs:0x1bdc0,%rax
ffffffff81056e08:	48 39 c7             	cmp    %rax,%rdi
ffffffff81056e0b:	0f 85 a3 24 15 01    	jne    ffffffff821a92b4 <show_stack.cold>
ffffffff81056e11:	48 83 05 af 0f c9 02 01 	addq   $0x1,0x2c90faf(%rip)        # ffffffff83ce7dc8 <__gcov0.show_stack+0x28>
ffffffff81056e19:	48 89 ee             	mov    %rbp,%rsi
ffffffff81056e1c:	48 89 d1             	mov    %rdx,%rcx
ffffffff81056e1f:	48 89 f2             	mov    %rsi,%rdx
ffffffff81056e22:	31 f6                	xor    %esi,%esi
ffffffff81056e24:	e8 8e 20 15 01       	call   ffffffff821a8eb7 <show_trace_log_lvl>
ffffffff81056e29:	48 83 05 9f 0f c9 02 01 	addq   $0x1,0x2c90f9f(%rip)        # ffffffff83ce7dd0 <__gcov0.show_stack+0x30>
ffffffff81056e31:	5d                   	pop    %rbp
ffffffff81056e32:	e9 49 b2 5a 01       	jmp    ffffffff82602080 <__x86_return_thunk>
ffffffff81056e37:	48 83 05 69 0f c9 02 01 	addq   $0x1,0x2c90f69(%rip)        # ffffffff83ce7da8 <__gcov0.show_stack+0x8>
ffffffff81056e3f:	65 48 8b 3c 25 c0 bd 01 00 	mov    %gs:0x1bdc0,%rdi
ffffffff81056e48:	eb ac                	jmp    ffffffff81056df6 <show_stack+0x16>
ffffffff81056e4a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

-- 
Josh
