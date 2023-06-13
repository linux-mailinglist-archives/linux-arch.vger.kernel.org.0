Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEB772DF12
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 12:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbjFMKTK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 06:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbjFMKTJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 06:19:09 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A88187;
        Tue, 13 Jun 2023 03:19:08 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-33e585a0ca6so20671155ab.3;
        Tue, 13 Jun 2023 03:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686651548; x=1689243548;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZGZZQK+1qfBDERk2tuB1aLbh7nI+UyNwane24jIPm+M=;
        b=L1yiON2XmbvcDIwqHEMaMwN61Gi5T51fhaPU24IDuhekO5USQn8Uv6ZQDU3n2oK7+l
         KFbkPPg/BKpDlWwugUEqTSCwSpzM5VF1MWyf2B7ub1pJf+zt1kQRtRYcwRwLvpas3syF
         u9mWXb9ZkmSZEtRqWNmTrMgPpAYnRnLmLMFurf6ipf8ebd+jcJnCGDz9cxVq0b330np/
         u/dz/4l6gQ98AbghKkD0QAu8Gud/Kh7CFaWMqAG1md9mhSO/GGNe0ZloZC2UKp0EI7co
         IxpVvnZxFhDBLNgFZeu+fpMN0ALtEybM7Vad0+6LTBr7Pb25VKUuN4USwtGvHdrX3DO/
         Bfug==
X-Gm-Message-State: AC+VfDy5WNGNPY+YmcGiwS1UJYelpIsCrYD7hDC9y8djwpzkPYVg6Jud
        Eyqvt45b2NZUDggiDjNGhA==
X-Google-Smtp-Source: ACHHUZ4YbPi+dVjDqClBdyqHAnFOuuSiVPdfpssZVvsbOyvlW1vIkmv7fDwVxTfy4eUAkDUbbwORfw==
X-Received: by 2002:a6b:7614:0:b0:777:b377:b225 with SMTP id g20-20020a6b7614000000b00777b377b225mr10228083iom.11.1686651547869;
        Tue, 13 Jun 2023 03:19:07 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z23-20020a029f17000000b00422cf285ed1sm149264jal.11.2023.06.13.03.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:19:07 -0700 (PDT)
Received: (nullmailer pid 1311615 invoked by uid 1000);
        Tue, 13 Jun 2023 10:19:01 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>, linux-arch@vger.kernel.org
In-Reply-To: <20230613094606.334687-3-corbet@lwn.net>
References: <20230613094606.334687-1-corbet@lwn.net>
 <20230613094606.334687-3-corbet@lwn.net>
Message-Id: <168665154172.1311568.8471309596161026195.robh@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: fix dangling Documentation/arm64
 reference
Date:   Tue, 13 Jun 2023 04:19:01 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
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

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/cpu/idle-states.yaml: Documentation/arch/arm64/booting.rst

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230613094606.334687-3-corbet@lwn.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

