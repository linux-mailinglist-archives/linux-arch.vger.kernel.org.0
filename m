Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E006C3F6D
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 02:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCVBHq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 21:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjCVBHq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 21:07:46 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B12258B52;
        Tue, 21 Mar 2023 18:07:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ek18so66789641edb.6;
        Tue, 21 Mar 2023 18:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679447263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b80iEQq+E/c4ggDzk5GW+bPChVMjL4Y7DHAArC/AiGg=;
        b=qEtsgXhWuiFAWcxNYR4IlkQytlhhzY+bVqx1K8sRmL1yX0KBevUuPPwtoy8tqWksIX
         rw28Gihhq+NG+LUEvEP9toIaHVxXJXMhFCuQwwD3gbGWwYrgBaXIz6yWu55Lj4x6Zz/4
         Uq8W75pde0kR6HhxQl+A0AvRkYYfY8SQYRxzdzYAuux6hcExG+behKYe59Aao1rUZimL
         kgZLTAQu+F5K4q/Ykntd8RRF0d6E0DS+iEaAuYEntZRW7grLYLec5OTvyA4wicyTgPJA
         Deo30yR3QJQ7HvJfhM5WSoBAkQD1ol80gfNXAWmRNz7sLuMD5iiNuLyZaqyM5M303Z4+
         g+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679447263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b80iEQq+E/c4ggDzk5GW+bPChVMjL4Y7DHAArC/AiGg=;
        b=FhwxgluHxk859pFIcprWJzY0ZGksgo1SkLrCW7/e2VZHYv21GJZbpi/H2XX9I9KPe2
         y3IJUU15TPBFyWdc8g62IBhcrFvP1EElYI3tppzJ3KbH/LtESs3tTrmKNbo2adp3G18t
         SaUkeA7cBkQRh4YNN+fl6t+weTPS/EiWnx0dTer4uJsIX6hYI0NbmF6iT7Ehe5aGpfEq
         Wq8JEtMroYSZ1RopzzIVQkr3xaaKJbWuCKK5VOCgt86D55WGH5U0rDg38fO1qPD6r7Pv
         SrDM9Uk9FK6FfSVpJp5at9PTeuQFLzYoIHMRfGVvREbc7p0ogjXcU35d4GRdpXtKB28X
         QhUQ==
X-Gm-Message-State: AO0yUKUHybVna6pkSCpKeeUGkibi1e1kj0kr00PfHqw1oplvU2PCIrEi
        qIF7WkCVaqI3Jj5w77IbTPTLtq2PkLo9gs6l
X-Google-Smtp-Source: AK7set+eKWvMThQCWgtrEntBn9puV2k7oxkTxG8EtKruBl2/qTrzqakGMmpgHKNbEIF+AeyMkoUWdg==
X-Received: by 2002:a17:906:4d16:b0:930:e3a0:8636 with SMTP id r22-20020a1709064d1600b00930e3a08636mr5185832eju.57.1679447262947;
        Tue, 21 Mar 2023 18:07:42 -0700 (PDT)
Received: from andrea (93-41-0-79.ip79.fastwebnet.it. [93.41.0.79])
        by smtp.gmail.com with ESMTPSA id l16-20020a1709061c5000b00939ad35d521sm1675599ejg.77.2023.03.21.18.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 18:07:42 -0700 (PDT)
Date:   Wed, 22 Mar 2023 02:07:40 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: Re: [PATCH memory-model 5/8] tools/memory-model: Provide exact SRCU
 semantics
Message-ID: <ZBpU3BAqmTQHxEyN@andrea>
References: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
 <20230321010246.50960-5-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321010246.50960-5-paulmck@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> +let carry-srcu-data = (data ; [~ Srcu-unlock] ; rf)*

> +let carry-dep = (data ; [~ Srcu-unlock] ; rfi)*

Nit: we use "~M" (no space after the unary operator) in this file, is
there a reason for the different styles?

  Andrea
