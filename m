Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5216F2010
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 23:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjD1VYQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 17:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjD1VYP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 17:24:15 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAD91BFA;
        Fri, 28 Apr 2023 14:24:14 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-390723f815fso194190b6e.3;
        Fri, 28 Apr 2023 14:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682717053; x=1685309053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAPY815zoxAtMPmlMXHufDygNyWf4XGrhN0PoJVnSps=;
        b=bLskf3YC/l8X3R50nlODXYqY5qLQQwyVkhV8DqaFv8aTh60n4nSxeh4wQ/s3UUwOKb
         3Mh4Mga16lSJjSHBjlRy70yKSqI3LosBFnU72luFpJpm49nGbJwncY3/jnazZE6Ow/Gl
         cJp7j1k74KKeeHies1L+gRhkygdK6qM6HNJg7syxMjQrazyPG+5i1qSJp5D64wZYtik0
         kFi108PeaNtHnENVF4l9e/OUP4ne2JPq1CMHhaNeS/Agi45bsN94ATdSTmCkRgwE5Tu1
         3hgLsa1DZ2PjmlVBr8ht+GkhQOmjDZNvxr59etaOY41dJBptbCHHQ9dA5JCA6Scg+BIG
         +I5A==
X-Gm-Message-State: AC+VfDzeiQBuuEURnU4cWmfoqJhD7iHiHf+TyLHDibS1U3sH3/csdx2N
        469WvXz+Z6L1cbBp639nhg==
X-Google-Smtp-Source: ACHHUZ4ejwMUkARoZivIyIZvQ1OVmA6kIV/k9dm1oOfq0PdWN5jKAu6yLm5KZXEfQ/nrJ6VzEGxTwQ==
X-Received: by 2002:a05:6808:2787:b0:38e:dc5b:7bc0 with SMTP id es7-20020a056808278700b0038edc5b7bc0mr3045160oib.59.1682717053559;
        Fri, 28 Apr 2023 14:24:13 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j6-20020acab906000000b00383eaea5e88sm9096118oif.38.2023.04.28.14.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 14:24:12 -0700 (PDT)
Received: (nullmailer pid 299800 invoked by uid 1000);
        Fri, 28 Apr 2023 21:24:11 -0000
Date:   Fri, 28 Apr 2023 16:24:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yi-De Wu <yi-de.wu@mediatek.com>
Cc:     Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mediatek@lists.infradead.org,
        David Bradil <dbrazdil@google.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: hypervisor: Add MediaTek GenieZone
 hypervisor
Message-ID: <20230428212411.GA292303-robh@kernel.org>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
 <20230428103622.18291-3-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428103622.18291-3-yi-de.wu@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 28, 2023 at 06:36:17PM +0800, Yi-De Wu wrote:
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> 
> Add documentation for GenieZone(gzvm) node. This node informs gzvm
> driver to start probing if geniezone hypervisor is available and
> able to do virtual machine operations.

Why can't the driver just try and do virtual machine operations to see 
if the hypervisor is there? IOW, make your software interfaces 
discoverable. DT is for non-discoverable hardware.

Rob
