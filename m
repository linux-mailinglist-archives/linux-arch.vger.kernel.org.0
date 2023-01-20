Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45650675B4A
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 18:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjATR2k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 12:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjATR2i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 12:28:38 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559D1C13DB;
        Fri, 20 Jan 2023 09:28:36 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-142b72a728fso6930717fac.9;
        Fri, 20 Jan 2023 09:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b2FYVPIl+D0PnDq4IjU2BhxrxH0daFPZx2nrrTLZA2U=;
        b=WT0romxD37GyryqIDpuGWVrYBj5eN9Z0weLKCOqUZjsn4kD4zm87eam3kqo4dLqAFq
         aO9wTCqwTrq9cVrq4tnI7ehQBKpDq/YJjJqHgVsKF5P5sYhIOMX20DSbalxCME7h3+bM
         29ZUg7dBMAKrrJOBwiKOaodEEnKunJ0owbP09mZw3hf8xq6xi2wafMNcyeLCyr8lBsfa
         H53g4oVWZFzM7zKxN95XuTl3HC6/1UfRVcHUeolORQ5GdvloVur9WyTN+rFhzNa4pxnO
         rutna3wnQnUQxpvl5iXb4N4t1rfgtR8OY+x2ceJOLyURFYoi9GhfV2x5DzT5fEgC8Ymp
         hUFg==
X-Gm-Message-State: AFqh2kq5pc7MQcOwzmxtwnyraC7Pl7qsD/y9WacMGN6zhAcSRrI1rJRW
        Uv9henFZgZuatFNv3ce29g==
X-Google-Smtp-Source: AMrXdXs/a3aPc3pTP32hlK8IkqfqJXIDHR/mq2KoSMM4aeg5SDCNOMtjboOVFJxsm+RI+WA4ERM+1A==
X-Received: by 2002:a05:6870:6b06:b0:157:26e1:239b with SMTP id mt6-20020a0568706b0600b0015726e1239bmr8695139oab.12.1674235715345;
        Fri, 20 Jan 2023 09:28:35 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i8-20020a056870344800b0013b92b3ac64sm21891971oah.3.2023.01.20.09.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:28:34 -0800 (PST)
Received: (nullmailer pid 1329669 invoked by uid 1000);
        Fri, 20 Jan 2023 17:28:32 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Louis Morhet <lmorhet@kalray.eu>,
        Arnd Bergmann <arnd@arndb.de>,
        Julien Villette <jvillette@kalray.eu>,
        Mark Brown <broonie@kernel.org>, linux-doc@vger.kernel.org,
        Bibo Mao <maobibo@loongson.cn>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Nick Piggin <npiggin@gmail.com>,
        ", Bharat Bhushan" <bbhushan2@marvell.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Marc_Poulhi=C3=A8s?= <dkm@kataplop.net>,
        bpf@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Borne <jborne@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        John Garry <john.garry@huawei.com>, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Christian Brauner <brauner@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Atish Patra <atishp@atishpatra.org>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        ", Thomas Gleixner" <tglx@linutronix.de>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arch@vger.kernel.org,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Costis <tcostis@kalray.eu>,
        Qi Liu <liuqi115@huawei.com>,
        Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Julian Vetter <jvetter@kalray.eu>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marius Gligor <mgligor@kalray.eu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        Samuel Jones <sjones@kalray.eu>, WANG Xuerui <git@xen0n.name>
In-Reply-To: <20230120141002.2442-3-ysionneau@kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-3-ysionneau@kalray.eu>
Message-Id: <167423561426.1325837.1311424254927277836.robh@kernel.org>
Subject: Re: [RFC PATCH v2 02/31] Documentation: Add binding for
 kalray,kv3-1-core-intc
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


On Fri, 20 Jan 2023 15:09:33 +0100, Yann Sionneau wrote:
> From: Jules Maselbas <jmaselbas@kalray.eu>
> 
> Add documentation for `kalray,kv3-1-core-intc` binding.
> 
> Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> ---
> 
> Notes:
>     V1 -> V2: new patch
> 
>  .../kalray,kv3-1-core-intc.yaml               | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml: properties:reg:maxItems: 0 is less than the minimum of 1
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml: $id: 'http://devicetree.org/schemas/interrupt-controller/kalray,kv3-1-core-intc#' does not match 'http://devicetree.org/schemas/.*\\.yaml#'
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml: properties:reg: 'anyOf' conditional failed, one must be fixed:
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	1 was expected
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	0 is less than the minimum of 2
		hint: Arrays must be described with a combination of minItems/maxItems/items
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml: properties: 'anyOf' conditional failed, one must be fixed:
	'interrupt-controller' is a required property
	'interrupt-map' is a required property
	from schema $id: http://devicetree.org/meta-schemas/interrupts.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml: properties:kalray,intc-nr-irqs: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml: properties:kalray,intc-nr-irqs: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml: properties:kalray,intc-nr-irqs: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
./Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/interrupt-controller/kalray,kv3-1-core-intc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230120141002.2442-3-ysionneau@kalray.eu

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

