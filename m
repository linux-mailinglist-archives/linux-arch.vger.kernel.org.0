Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B82E67D0FB
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 17:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjAZQKl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 11:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjAZQKk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 11:10:40 -0500
Received: from fx409.security-mail.net (smtpout140.security-mail.net [85.31.212.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B737C4DE2B
        for <linux-arch@vger.kernel.org>; Thu, 26 Jan 2023 08:10:38 -0800 (PST)
Received: from localhost (fx409.security-mail.net [127.0.0.1])
        by fx409.security-mail.net (Postfix) with ESMTP id 2B8FF349782
        for <linux-arch@vger.kernel.org>; Thu, 26 Jan 2023 17:10:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674749437;
        bh=18h0PvVkWw5cOD2tUF5rJDodhNIHFoyGd3swtBhEV9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=2j+PLAfcFq/dMJAm7QTIXrm0muDDhYaPROPgytN3gaTJa6LkYepek8NuWASCmXbjk
         BSj8xuje1RDBvbgEdTd13Bs0SSELaXlSeYbazQnkW+tgJ0bzaaR5DZK2kqeKnsxeVO
         V/F0b4xMun1FYOPN9Q3rOIJWltJMZCMOaHln8qIs=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 6CDFA3496E5; Thu, 26 Jan
 2023 17:10:36 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx409.security-mail.net (Postfix) with ESMTPS id 42F9E3496BD; Thu, 26 Jan
 2023 17:10:35 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 0E32B27E0492; Thu, 26 Jan 2023
 17:10:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id E364B27E0431; Thu, 26 Jan 2023 17:10:34 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 DTQUInwcUDo5; Thu, 26 Jan 2023 17:10:34 +0100 (CET)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 8E3C527E0374; Thu, 26 Jan 2023
 17:10:34 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <4f4e.63d2a5fb.40271.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu E364B27E0431
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674749435;
 bh=9giavlvQOACZW0fqif+Jno6XkcerIxtPM3AoszI6iXA=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=gjg/x2TlOcjiKN3NypFbIHFe/byI2jjV8o3VpLfw+6A29RvT0tO7rhyOLP4RSQBmB
 x4Tx+6M47/jYTq+5ZLA2uCIUhHGzwDXxt8eUceRV5P9eFpkBGwoYQYAzaEc236wUu9
 1kIkSP3K+m+aYLf/4oc9MR/KzKUTElR11/fHsdhg=
Date:   Thu, 26 Jan 2023 17:10:33 +0100
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Atish Patra <atishp@atishpatra.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH v2 02/31] Documentation: Add binding for
 kalray,kv3-1-core-intc
Message-ID: <20230126161032.GH5952@tellis.lin.mbt.kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-3-ysionneau@kalray.eu>
 <d4d998ee-1532-c896-df25-195ec9c72e3f@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d4d998ee-1532-c896-df25-195ec9c72e3f@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Krzysztof,

On Sun, Jan 22, 2023 at 12:44:46PM +0100, Krzysztof Kozlowski wrote:
> On 20/01/2023 15:09, Yann Sionneau wrote:
> > From: Jules Maselbas <jmaselbas@kalray.eu>
> 
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching).
This will be fixed, sorry for the inconvenience.

> 
> > 
> > Add documentation for `kalray,kv3-1-core-intc` binding.
> > 
> > Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
> > Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> > Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> > ---
> > 
> > Notes:
> >     V1 -> V2: new patch
> > 
> >  .../kalray,kv3-1-core-intc.yaml               | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml
> > new file mode 100644
> > index 000000000000..1e3d0593173a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interrupt-controller/kalray,kv3-1-core-intc#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Kalray kv3-1 Core Interrupt Controller
> > +
> > +description: |
> > +  The Kalray Core Interrupt Controller is tightly integrated in each kv3 core
> > +  present in the Coolidge SoC.
> > +
> > +  It provides the following features:
> > +  - 32 independent interrupt sources
> > +  - 2-bit configurable priority level
> > +  - 2-bit configurable ownership level
> > +
> > +allOf:
> > +  - $ref: /schemas/interrupt-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: kalray,kv3-1-core-intc
> 
> Blank line between each of these,
Ack

> > +  "#interrupt-cells":
> > +    const: 1
> > +    description:
> > +      The IRQ number.
> > +  reg:
> > +    maxItems: 0
> 
> ??? No way... What's this?
This (per CPU) interrupt controller is not memory mapped at all, it is
controlled and configured through system registers.

I do not have found existing .yaml bindings for such devices, only the
file snps,archs-intc.txt has something similar.

I do not know what is the best way to represent such devices in the
device-tree.  Any suggestions are welcome.

> 
> > +  "kalray,intc-nr-irqs":
> 
> Drop quotes.
> 
> > +    description: Number of irqs handled by the controller.
> 
> Why this is variable per board? Why do you need it ?
This property is not even used in our device-tree, this will be removed
from the documentation and from the driver as well.

> > +
> > +required:
> > +  - compatible
> > +  - "#interrupt-cells"
> > +  - interrupt-controller
> 
> missing additionalProperties: false
> 
> This binding looks poor, like you started from something odd. Please
> don't. Take the newest reviewed binding or better example-schema and use
> it to build yours. This would solve several trivial mistakes and style
> issues.
I am starting over from the example-schema.

> > +
> > +examples:
> > +  - |
> > +    intc: interrupt-controller {
> 
> What's the IO address space?
As said above, this is not a memory mapped device, but is accessed
through system registers.

Thanks,
-- Jules




