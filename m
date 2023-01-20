Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E82675B56
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 18:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjATR2w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 12:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjATR2r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 12:28:47 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CE2BF8B4;
        Fri, 20 Jan 2023 09:28:42 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id x21-20020a056830245500b006865ccca77aso3457913otr.11;
        Fri, 20 Jan 2023 09:28:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9HSgCQCxDRt/ES8CSO81S+bMV2W0e0O/4hQkm1CKfbA=;
        b=Zl57xxI5i9wDwNRHpqyb4vRx10UQwl6qK4y5USdfJtiPeuwI15dxh6QWK8u3JXUrRM
         Oe9G2S26+wRZH5BY8F2WJqCJjeooGzzofpjUj8riiFoKd/49Za0pzQMezkQFRtORBRbb
         6N+/i5rAdQWi7c6aEemaHOKF2xrIFNulnJcuhehkSWskKQHXPBSL2z7dHn4Yovg/MZuP
         X7iHXHXW6TfRxw+ij/8yl1Cpm05iCHsBjwBH0WeeoYh2ScmJoTAnS1UAyDtu4OLNCNSl
         nIJpAo8OJSoHl8THL9dbdr1nsHusD+Ofb+eumoBXnzaHMST95iQxVwAiHGXaGerpfbkV
         e+BQ==
X-Gm-Message-State: AFqh2kr8Scig5cmbAbkOt7/b3g+ZkRWEUsmq/ylgLnEbRmocDEc78sqU
        g8lUZSoe2/7jm8AiwjHVcA==
X-Google-Smtp-Source: AMrXdXs87XWf1uJ29pt4F76PCQm1VpwDoqJpVdMTPVfzjFv4uCqY7pHkuEjoheseeck2vFnJTqwQuw==
X-Received: by 2002:a05:6830:201a:b0:685:85bd:3fc9 with SMTP id e26-20020a056830201a00b0068585bd3fc9mr7086097otp.36.1674235722043;
        Fri, 20 Jan 2023 09:28:42 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y13-20020a9d714d000000b00661a16f14a1sm6072663otj.15.2023.01.20.09.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:28:41 -0800 (PST)
Received: (nullmailer pid 1329674 invoked by uid 1000);
        Fri, 20 Jan 2023 17:28:32 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     linux-mm@kvack.org, Guillaume Missonnier <gmissonnier@kalray.eu>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marius Gligor <mgligor@kalray.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        =?UTF-8?Q?Marc_Poulhi=C3=A8s?= <dkm@kataplop.net>,
        Luc Michel <lmichel@kalray.eu>,
        Nick Piggin <npiggin@gmail.com>, Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        linux-riscv@lists.infradead.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Samuel Jones <sjones@kalray.eu>,
        Eric Biederman <ebiederm@xmission.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Mark Brown <broonie@kernel.org>,
        John Garry <john.garry@huawei.com>, linux-doc@vger.kernel.org,
        Clement Leger <clement@clement-leger.fr>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Louis Morhet <lmorhet@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Jonathan Borne <jborne@kalray.eu>,
        Eric Paris <eparis@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        ", Guangbin Huang" <huangguangbin2@huawei.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Julien Hascoet <jhascoet@kalray.eu>, bpf@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Julien Villette <jvillette@kalray.eu>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Huacai Chen <chenhuacai@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        WANG Xuerui <git@xen0n.name>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Julian Vetter <jvetter@kalray.eu>
In-Reply-To: <20230120141002.2442-5-ysionneau@kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-5-ysionneau@kalray.eu>
Message-Id: <167423561602.1325928.9348232988456790495.robh@kernel.org>
Subject: Re: [RFC PATCH v2 04/31] Documentation: Add binding for
 kalray,kv3-1-apic-mailbox
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


On Fri, 20 Jan 2023 15:09:35 +0100, Yann Sionneau wrote:
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
>  .../kalray,kv3-1-apic-mailbox.yaml            | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-apic-mailbox.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-apic-mailbox.yaml: $id: 'http://devicetree.org/schemas/interrupt-controller/kalray,kv3-1-apic-mailbox#' does not match 'http://devicetree.org/schemas/.*\\.yaml#'
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-apic-mailbox.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-apic-mailbox.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-apic-mailbox.yaml: properties:interrupt-parent: False schema does not allow True
	from schema $id: http://devicetree.org/meta-schemas/interrupts.yaml#
./Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-apic-mailbox.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/interrupt-controller/kalray,kv3-1-apic-mailbox.yaml#
Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-apic-mailbox.example.dtb: /example-0/interrupt-controller@a00000: failed to match any schema with compatible: ['kalray,kv3-1-apic-gic']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230120141002.2442-5-ysionneau@kalray.eu

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

