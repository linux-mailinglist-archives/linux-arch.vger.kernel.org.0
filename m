Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E652F6F1AE6
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 16:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjD1Owg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 10:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjD1Owf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 10:52:35 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8038B213A;
        Fri, 28 Apr 2023 07:52:34 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-b99e0ffbabbso8368999276.1;
        Fri, 28 Apr 2023 07:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682693553; x=1685285553;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gaFAPotc4Tet+5Lkq4Wes2jlNlqpTRGPPd/XZUEUiMw=;
        b=doKCwnAh12tTbCQ7uzqUkqSPhYgos32YyykESneiFDy5O4iE4WQ+CrpOIfh9TtkwHW
         PowiYFNT/rLpSQKsa/aOJxRKI9VPK9ZQRA5WQpDtnjiYcGhiu7/9uGUID+Op+Wabhvs0
         XZlpVjowOpvaUoflylYVk7ttNsTTieVZrWmyVOim8Q00P6VziILzfhAuEk5FjY/DkJsQ
         yMFwy6vpLDLBvU0G9gGw2b7uaeMvrcMDNASPx65P5cEBgvkSDXkarTzGr60C3xPXeUny
         N09K/0Guhawvio+1s4vwtcYB3rugPhg07Pt4NGqtpyAgKVbUdluWZctKhaWi9+FzW9h9
         H/ZQ==
X-Gm-Message-State: AC+VfDyB6eS3snCvWLocgSmhDcNv6nkOtIASjETnRbo3NbjsqoqIhvCd
        y7meAibK0YzuADO+KjN9ug==
X-Google-Smtp-Source: ACHHUZ5NBWHe8QhTsN+gWIF0zuKZ1dCFoewZMy4/csM/yFA+609U4TQP8o3KAwNDbQ5ThRLXTaLv6A==
X-Received: by 2002:a25:1586:0:b0:b9a:6d87:f4cf with SMTP id 128-20020a251586000000b00b9a6d87f4cfmr4095959ybv.2.1682693553378;
        Fri, 28 Apr 2023 07:52:33 -0700 (PDT)
Received: from robh_at_kernel.org (75-148-192-78-Houston.hfc.comcastbusiness.net. [75.148.192.78])
        by smtp.gmail.com with ESMTPSA id a16-20020a056902057000b00b96816d3790sm5149099ybt.36.2023.04.28.07.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 07:52:32 -0700 (PDT)
Received: (nullmailer pid 3983 invoked by uid 1000);
        Fri, 28 Apr 2023 14:52:31 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Yi-De Wu <yi-de.wu@mediatek.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-doc@vger.kernel.org, Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-arch@vger.kernel.org,
        Jade Shih <jades.shih@mediatek.com>,
        linux-kernel@vger.kernel.org, My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Bradil <dbrazdil@google.com>
In-Reply-To: <20230428103622.18291-3-yi-de.wu@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
 <20230428103622.18291-3-yi-de.wu@mediatek.com>
Message-Id: <168269352006.3076.11433928748883862569.robh@kernel.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: hypervisor: Add MediaTek GenieZone
 hypervisor
Date:   Fri, 28 Apr 2023 09:52:31 -0500
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


On Fri, 28 Apr 2023 18:36:17 +0800, Yi-De Wu wrote:
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> 
> Add documentation for GenieZone(gzvm) node. This node informs gzvm
> driver to start probing if geniezone hypervisor is available and
> able to do virtual machine operations.
> 
> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
> ---
>  .../hypervisor/mediatek,geniezone-hyp.yaml    | 31 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-hyp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-hyp.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/hypervisor/mediatek,geniezone-hyp.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230428103622.18291-3-yi-de.wu@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

