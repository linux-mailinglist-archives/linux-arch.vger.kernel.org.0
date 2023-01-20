Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DD6675B59
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 18:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjATR3D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 12:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjATR2s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 12:28:48 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DCDC79DE;
        Fri, 20 Jan 2023 09:28:45 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-142b72a728fso6931231fac.9;
        Fri, 20 Jan 2023 09:28:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5gjBA06WD67YyrMoXqvO6J1PCDs2JLwdpFR7b9qxItY=;
        b=XCeTpyCus0VUWsLLQT8iNwK0CqFMx33f+xElnT2iAPorxuFPtzRp1P96T4N3zXZaJ/
         aYui74BardO4vJtMkV0RUJ2RS5K8JuDuOv/4/DA2nXiCTN3Blj2MpHRAZkzjqsTkTCxX
         9VpWj6vUxq1SU1HmxOwvXOiVbS9MdASObEEr/zdfkvT6nGLV0c3z/Cp+jTHRg+po7phK
         oLauGvj0iYilY7aItsi4Y4eI4Ur121kY5bhvQLSoHE34adfOlpbIttMRY9lItYmo8uCU
         0z4iNxYNco3SFtFokGXzTQEnVolk2R1k6ZiJorjLyLvOAtg+FPed6hajsOTelDnqIcol
         2COA==
X-Gm-Message-State: AFqh2kqSZw5ypg+fJheZGQDo3g9Dqseknw4mqJYeV/oTr+yVofxSdzkb
        +VMnJBhSgqEZ1ZqwVdksQA==
X-Google-Smtp-Source: AMrXdXsC2cOGm30AaJai4q7zhD2SMcLgQzNvcz66PRBIqSJXVFomWcJHEJ/jDByOesOFNWT0pQYdHA==
X-Received: by 2002:a05:6870:c08f:b0:15f:cf98:35af with SMTP id c15-20020a056870c08f00b0015fcf9835afmr1110684oad.2.1674235724686;
        Fri, 20 Jan 2023 09:28:44 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h3-20020a4ac443000000b004fb2935d0e7sm4395655ooq.36.2023.01.20.09.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:28:44 -0800 (PST)
Received: (nullmailer pid 1329678 invoked by uid 1000);
        Fri, 20 Jan 2023 17:28:32 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     Qi Liu <liuqi115@huawei.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Clement Leger <clement@clement-leger.fr>,
        Eric Biederman <ebiederm@xmission.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Atish Patra <atishp@atishpatra.org>,
        Waiman Long <longman@redhat.com>,
        John Garry <john.garry@huawei.com>, linux-audit@redhat.com,
        Eric Paris <eparis@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Marc Zyngier <maz@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Julian Vetter <jvetter@kalray.eu>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        ", Peter Zijlstra" <peterz@infradead.org>,
        Paul Moore <paul@paul-moore.com>,
        Thomas Costis <tcostis@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Marius Gligor <mgligor@kalray.eu>, devicetree@vger.kernel.org,
        Julien Villette <jvillette@kalray.eu>,
        =?UTF-8?Q?Marc_Poulhi=C3=A8s?= <dkm@kataplop.net>,
        Louis Morhet <lmorhet@kalray.eu>,
        Arnd Bergmann <arnd@arndb.de>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Janosch Frank <frankja@linux.ibm.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Bibo Mao <maobibo@loongson.cn>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Luc Michel <lmichel@kalray.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mark Brown <broonie@kernel.org>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Samuel Jones <sjones@kalray.eu>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Michon <amichon@kalray.eu>, bpf@vger.kernel.org,
        Nick Piggin <npiggin@gmail.com>, WANG Xuerui <git@xen0n.name>,
        Ingo Molnar <mingo@redhat.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>
In-Reply-To: <20230120141002.2442-7-ysionneau@kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-7-ysionneau@kalray.eu>
Message-Id: <167423561782.1326010.11195251542877567719.robh@kernel.org>
Subject: Re: [RFC PATCH v2 06/31] Documentation: Add binding for kalray,kv3-1-ipi-ctrl
Date:   Fri, 20 Jan 2023 11:28:32 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On Fri, 20 Jan 2023 15:09:37 +0100, Yann Sionneau wrote:
> From: Jules Maselbas <jmaselbas@kalray.eu>
> 
> Add documentation for `kalray,kv3-1-ipi-ctrl` binding.
> 
> Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> ---
> 
> Notes:
>     V1 -> V2: new patch
> 
>  .../kalray/kalray,kv3-1-ipi-ctrl.yaml         | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/kalray/kalray,kv3-1-ipi-ctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/kalray/kalray,kv3-1-ipi-ctrl.yaml: $id: 'http://devicetree.org/schemas/kalray/kalray,kv3-1-ipi-ctrl#' does not match 'http://devicetree.org/schemas/.*\\.yaml#'
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/kalray/kalray,kv3-1-ipi-ctrl.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/kalray/kalray,kv3-1-ipi-ctrl.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
./Documentation/devicetree/bindings/kalray/kalray,kv3-1-ipi-ctrl.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/kalray/kalray,kv3-1-ipi-ctrl.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/kalray/kalray,kv3-1-ipi-ctrl.example.dtb: inter-processor-interrupt@ad0000: reg: [[0, 11337728], [0, 4096]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/kalray/kalray,kv3-1-ipi-ctrl.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/kalray/kalray,kv3-1-ipi-ctrl.example.dtb: inter-processor-interrupt@ad0000: 'interrupt-parent' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/kalray/kalray,kv3-1-ipi-ctrl.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230120141002.2442-7-ysionneau@kalray.eu

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

