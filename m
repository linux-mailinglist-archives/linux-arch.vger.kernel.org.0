Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1258051BBEE
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 11:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347874AbiEEJ32 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 05:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352602AbiEEJ26 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 05:28:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C4EC52;
        Thu,  5 May 2022 02:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cFrv4fRAJbgjPhZjb23GzjlcKUZmkXNQsUuXMiPf8LE=; b=Lam/QAhfsOqG0Qp4Ar+FOMCPO0
        H+yJ3j/I31yMJ4CTIckx41H8TxJNd30/k4663TU4OMwVNQYmgD282sQpriumTjdKpko4tmu02S4gA
        +Q1scgiIuRbiie9JL2BhWjmyypxSSMFLuv6fAPM048VL6bML7dXCslpKKvtJj3dQ0BbHgyxO9dUoA
        XWtLmgTu6Zu0oDj8J/+0+pmq/4fnwxyHLp7noOVE799YtHgh4kXC/xiC6sWmjzm+if62KlSOvzZ8c
        mMsBFU+v2CKqFJXkNg6zzA6TdpFPPvqy+zeHaQ6RemBuxtecOqTphDe7LUPh4GBGoHUyGGiRDeHOR
        WiFUs7Aw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmXj8-00BKsp-6E; Thu, 05 May 2022 09:24:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 487A4980FA2; Thu,  5 May 2022 11:24:48 +0200 (CEST)
Date:   Thu, 5 May 2022 11:24:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, jthierry@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, masahiroy@kernel.org,
        jpoimboe@redhat.com, ycote@redhat.com, herbert@gondor.apana.org.au,
        mark.rutland@arm.com, davem@davemloft.net, ardb@kernel.org,
        maz@kernel.org, tglx@linutronix.de, luc.vanoostenryck@gmail.com
Subject: Re: [RFC PATCH v4 22/37] arm64: kernel: Skip validation of kuser32.o
Message-ID: <20220505092448.GE2501@worktop.programming.kicks-ass.net>
References: <20220429094355.122389-1-chenzhongjin@huawei.com>
 <20220429094355.122389-23-chenzhongjin@huawei.com>
 <YmvGja62yWdPHPOW@hirez.programming.kicks-ass.net>
 <a57f7d73-6e01-8f41-9be3-8e90807ec08f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a57f7d73-6e01-8f41-9be3-8e90807ec08f@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 05, 2022 at 11:36:12AM +0800, Chen Zhongjin wrote:
> Hi Peter,
> 
> IIRC now the blacklist mechanisms all run on check stage, which after
> decoding, but the problem of kuser32.S happens in decoding stage. Other
> than that the assembly symbols in kuser32 is STT_NOTYPE and
> STACK_FRAME_NON_STANDARD will throw an error for this.
> 
> OBJECT_FILES_NON_STANDARD works for the single file but as you said
> after LTO it's invalid. However STACK_FRAME_NON_STANDARD doesn't work
> for kuser32 case at all.
> 
> Now my strategy for undecodable instructions is: show an error message
> and mark insn->ignore = true, but do not stop anything so decoding work
> can going on.
> 
> To totally solve this my idea is that applying blacklist before decode.
> However for this part objtool doesn't have any insn or func info, so we
> should add a new blacklist just for this case...

OK, so Mark explained that this is 32bit userspace (VDSO) code.

And as such there's really no point in running objtool on it. Does all
that live in it's own section? Should it?

