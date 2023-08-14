Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A705077B728
	for <lists+linux-arch@lfdr.de>; Mon, 14 Aug 2023 12:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjHNK5u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Aug 2023 06:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjHNK5c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Aug 2023 06:57:32 -0400
Received: from out-74.mta1.migadu.com (out-74.mta1.migadu.com [95.215.58.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085841AA
        for <linux-arch@vger.kernel.org>; Mon, 14 Aug 2023 03:57:30 -0700 (PDT)
Message-ID: <a308e43a-2561-3d2b-28c7-eb3fe73cd43a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692010649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Avsj2c62N6j7AdW8celUMPzFdEhLy56lJnr2NPL70EI=;
        b=ksxZLgCXV2qViy3Zo12U1dTUkquFjlWdlbU1XTg0QIezs7qX5QgY9L4IPszPbte9dtmEdO
        OwDp7DHhUm0/EPw34jVZwFNL0vkSuJxT5kQUupaY+AKzSCJ/s+dSj9VUiSUoV2iwPM7pfN
        xwAU8GBfJdKepMa7W8nr4UhoZSemyuk=
Date:   Mon, 14 Aug 2023 18:57:18 +0800
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v1] docs/zh_CN: add zh_CN translation for
 memory-barriers.txt
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230811080851.84497-1-gang.li@linux.dev>
 <2f519a69-8f12-4c07-bf20-6776a5ada256@loongson.cn>
 <f8de40bf-1743-793f-7723-232adbfab623@linux.dev>
 <479156cf-1bdb-421a-8dab-0db8ff73012b@loongson.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Gang Li <gang.li@linux.dev>
In-Reply-To: <479156cf-1bdb-421a-8dab-0db8ff73012b@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 2023/8/14 15:58, Yanteng Si wrote:
> [PATCH  v2 1/2] docs: convert memory-barriers.txt to RST
> 


We already have a wrapper loading memory-barriers.txt into html:

https://www.kernel.org/doc/html/latest/core-api/wrappers/memory-barriers.html

Thanks,
Gang Li
