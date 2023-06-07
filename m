Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD657726F0A
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jun 2023 22:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbjFGUzZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Jun 2023 16:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjFGUzY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jun 2023 16:55:24 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488F3FC;
        Wed,  7 Jun 2023 13:55:22 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-77807e43b7cso171064839f.1;
        Wed, 07 Jun 2023 13:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686171321; x=1688763321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmEZi5N7YDhvNJy3rBTf1nv9aQf4pcdgMDQ8c9eSIts=;
        b=XDN67K4xYZaKoT8PHa7wQcbR2xa5BXuYHfvWmvMR+Dl0G3y2RcmplCszIqj1kmxRH1
         5RvhNwPlMe3RVY96xN1O1UgziVlQt4eD4h0HTjD6j+wRu7b7mbTLucVkgDQWb4viScJ2
         h1g7ESM7iXlXyvd8HVOgcv58dt94SR7rfVJ2VC9F/d7TwRZOwAOg0q7Sq5qHKG2bDTqz
         0gJiEsPKXE3mtp6c0aKhokzNRavQwH0u+zJf/nAKbsDJcLC1DM8BydyXmWpBxmfKghIs
         c65FZ0xCOsx1Jb8aiH5keJCYm6To0Mb8UgXLWpnCyPmFx6lJWAWHE3qJwI8R77uZpxNJ
         +IZQ==
X-Gm-Message-State: AC+VfDzS4cOupxAYjZztJ00kbOu/bOeeVK9SF3QXGZJ2zPSq6oYMkwRT
        Hq+wEMMLKqcT+gws0tYH2Q==
X-Google-Smtp-Source: ACHHUZ50g9WpxB5ClBkk/01DwUK2RDpLIcNYlcyd/phU1nq65gNr97Ezyo9t8h99nLUgOdWLbuAoKQ==
X-Received: by 2002:a6b:e312:0:b0:774:9b75:b463 with SMTP id u18-20020a6be312000000b007749b75b463mr10962172ioc.7.1686171321540;
        Wed, 07 Jun 2023 13:55:21 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f11-20020a056638022b00b0041854063710sm1801018jaq.134.2023.06.07.13.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 13:55:20 -0700 (PDT)
Received: (nullmailer pid 4005541 invoked by uid 1000);
        Wed, 07 Jun 2023 20:55:18 -0000
Date:   Wed, 7 Jun 2023 14:55:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arch@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 7/7] dt-bindings: Update Documentation/arm references
Message-ID: <168617131831.4005487.8758016906916072679.robh@kernel.org>
References: <20230529144856.102755-1-corbet@lwn.net>
 <20230529144856.102755-8-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529144856.102755-8-corbet@lwn.net>
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


On Mon, 29 May 2023 08:48:56 -0600, Jonathan Corbet wrote:
> The Arm documentation has moved to Documentation/arch/arm; update one
> devicetree reference to match.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: devicetree@vger.kernel.org
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/devicetree/bindings/arm/xen.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

