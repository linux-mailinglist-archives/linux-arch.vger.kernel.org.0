Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62D94DC34C
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 10:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiCQJt2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Mar 2022 05:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiCQJtY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2022 05:49:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58767B88;
        Thu, 17 Mar 2022 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yicCny8nHaglYevrNfwan/4wAlISyppq00h0F352WzQ=; b=ZP/S7WXk4z47FcQpOt16Es+QV/
        mHBHwX5fKFAqB8OgbZx6AiTNt2RxYoE7tq5GQMY90fLYxK6/+nm9tykIoDW6vqVP4G2ukcTEADEBt
        xTLqFxudQwo2nW6cZU+XiilIkB+IDfwTxFFUn6Mt4IkcHz/l2pEAptD8I3aZS29muBfzLygCcMLX3
        1Kb+fFyLIhNjMo0ZetK9ycqowu+OHIRYtXuPYuf9udj0ItwyLBisExr02IE0e3JrCp1LalMULVDbJ
        ZTWlZtcgsXUjWkVG8EH0OFTk1/yBNApnj5Ov6khXYYCURE8gsJPglhG4z8rbwVPPubCILUaopumkh
        t7Zr+Wsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUmjJ-001qtK-La; Thu, 17 Mar 2022 09:47:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC7883001EA;
        Thu, 17 Mar 2022 10:47:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD191201CD1C3; Thu, 17 Mar 2022 10:47:35 +0100 (CET)
Date:   Thu, 17 Mar 2022 10:47:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        mingo@redhat.com, Will Deacon <will@kernel.org>,
        longman@redhat.com, boqun.feng@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, jszhang@kernel.org,
        wangkefeng.wang@huawei.com, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 5/5] RISC-V: Move to queued RW locks
Message-ID: <YjMDt8BgtIZZH8IY@hirez.programming.kicks-ass.net>
References: <20220316232600.20419-1-palmer@rivosinc.com>
 <20220316232600.20419-6-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316232600.20419-6-palmer@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 16, 2022 at 04:26:00PM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> With the move to fair spinlocks, we might as well move to fair rwlocks.

s/might as well/can/ ?

Note that qrwlock relies on spinlock to be/provide fairness.

> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
