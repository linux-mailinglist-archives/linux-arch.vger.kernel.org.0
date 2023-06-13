Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BE172E45B
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 15:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbjFMNl3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 09:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbjFMNl3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 09:41:29 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639AAA0;
        Tue, 13 Jun 2023 06:41:26 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3408334f13bso964065ab.3;
        Tue, 13 Jun 2023 06:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686663685; x=1689255685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rbx0VWrs3HFsA/s9c93FaA4vnwvC22becHxvi6QWIE=;
        b=k9xQtCU7J1eA9wnl9ZL8vISH+GT+3aK8hjZbQG8fbVWCGvAkiIIN33wRgUIUjLDHnY
         l3LvzhXobapojenklKLr1LpaOwxm6tiGxMGf5IPdtdQnOsSUj292+uZ43r17ZHm8/jCz
         kzEj/Nt5T1XZG37FehGqRPcOQ17FsLoN7kZWm0QmtLta9yz+wNFsNAy44lLLwbYZ7j3h
         8AfkQTK0NyXgHpN5iFEpW0apGtWdjaaMkYvR7JIUwLfBsoeNpUIJ7qOOTv5nr9CoWa3u
         cO8xDeUrVR54gJpzut+O2md91hISwEW1yGIZAp3/ZH2aGOMa78+Al2wbVxuwTbdfMosY
         ucSA==
X-Gm-Message-State: AC+VfDwnr6JJs1ZCw0czQ1dHpjK++q2Y5/0PxmgWQ94rF0f6AM11xXn3
        Zkh62kdmfUBr8yhAxpclcA==
X-Google-Smtp-Source: ACHHUZ6g6fG1U9+HhD9QRmQYALt+/3mKSAusBdqvSzJQNEB/L6R3hXFfsRgVErWwoodzT+QagllJlQ==
X-Received: by 2002:a92:cd11:0:b0:331:5cf:e4ca with SMTP id z17-20020a92cd11000000b0033105cfe4camr10030919iln.8.1686663685542;
        Tue, 13 Jun 2023 06:41:25 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a11-20020a92a30b000000b0033ce0ef231bsm705234ili.23.2023.06.13.06.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 06:41:25 -0700 (PDT)
Received: (nullmailer pid 1777526 invoked by uid 1000);
        Tue, 13 Jun 2023 13:41:23 -0000
Date:   Tue, 13 Jun 2023 07:41:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: fix dangling Documentation/arm64
 reference
Message-ID: <168666368299.1777466.3722414650571567037.robh@kernel.org>
References: <20230613094606.334687-1-corbet@lwn.net>
 <20230613094606.334687-3-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613094606.334687-3-corbet@lwn.net>
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


On Tue, 13 Jun 2023 03:46:03 -0600, Jonathan Corbet wrote:
> The arm64 documentation has move under Documentation/arch/ fix a reference
> to match.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/devicetree/bindings/cpu/idle-states.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

