Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA0577BBB6
	for <lists+linux-arch@lfdr.de>; Mon, 14 Aug 2023 16:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjHNOcX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Aug 2023 10:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjHNOcM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Aug 2023 10:32:12 -0400
Received: from out-76.mta0.migadu.com (out-76.mta0.migadu.com [IPv6:2001:41d0:1004:224b::4c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3DEE4
        for <linux-arch@vger.kernel.org>; Mon, 14 Aug 2023 07:32:11 -0700 (PDT)
Message-ID: <34b2f16b-2ce0-a5eb-b377-df4688372027@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692023527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pxC2fYhONXFJiyWnZ7/OJ94Fr5is2Wfvs+6qKGB7V8A=;
        b=DxuN+IgKzugUwS5BVE4dAbsz5JFQNgPeAU1wA37IGmwoN4L3lDO5htrWXbh1eQIg6CEcUd
        aKXzQS5YX+KBIcLpFL+wpJnhbfxqr4lmFitFwNiQHTQw1yjP8ZoUxON1cc2c27I2JrPQSO
        XXBwjtsb+BZAPtOOv8J+NofzOxpJC64=
Date:   Mon, 14 Aug 2023 22:31:56 +0800
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v1] docs/zh_CN: add zh_CN translation for
 memory-barriers.txt
Content-Language: en-US
To:     Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Alex Shi <alexs@kernel.org>, Akira Yokosawa <akiyks@gmail.com>,
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
 <87o7j9wzx1.fsf@meer.lwn.net>
 <97c18b17-047d-4ec9-8698-8d4afffbc27b@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Gang Li <gang.li@linux.dev>
In-Reply-To: <97c18b17-047d-4ec9-8698-8d4afffbc27b@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

OK, will do it in v2.

On 2023/8/14 21:14, Yanteng Si wrote:
> 
> As Jon said, you need to create a wrapper for the translated 
> memory-barriers.txt.
> 
> 
