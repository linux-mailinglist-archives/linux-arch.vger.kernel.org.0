Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C342E332BA1
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 17:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhCIQLw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 11:11:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231919AbhCIQL3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Mar 2021 11:11:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2F4C64FBD;
        Tue,  9 Mar 2021 16:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615306289;
        bh=jP4SlGRYL9z9+eyGPwRsaTLzvGEXcjhnvO8W76wpgNg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZVrTVRlsTUZ6UvAFSqnFRXzFTuQ+RTH+KKVz80hwNJhcVb8oPDqu3VUXPxU08MljE
         KwQn8X4P+k3aO/P71x48UcI3mUXon9e0sO13vmZTlYMgq5vLgEnwqAFq9sKDfMkxTd
         mDT80HetJ45/BY6gIZetj74YgC344aL8/8eHU48l2pI2a5a9g64isjQpFurdbGLNpM
         1ycmOuKDCP2N2pkLoFejOEAw0aDIBrZeyVy/G/6GwYn4rhVAfdqB5arhHGktPsqT5V
         PeMh/vzPynAhkBZcSvYJte7w9F2ZVQNfDAeX5D1G++lMklup3F8WUxdNtaqCcjZCBh
         DYVpOQRq4uP0g==
Received: by mail-ej1-f51.google.com with SMTP id mm21so29127530ejb.12;
        Tue, 09 Mar 2021 08:11:28 -0800 (PST)
X-Gm-Message-State: AOAM532T7NmkX/hNtCfMVF5q3eEgNw8crSJFhcaNx+IFZWOk9iNMQg71
        ErdB+TjmR+QOtRKIININtW9Sa+63bED9c4aPjg==
X-Google-Smtp-Source: ABdhPJyUkLV5udpIPwopun4y9FIyMOM7Kb/GLOh2/MhA1kzOLho0N807A6srQjeEqqxkaM/xpiP2WAOCDXgqauEOczc=
X-Received: by 2002:a17:906:25c4:: with SMTP id n4mr21228200ejb.359.1615306287477;
 Tue, 09 Mar 2021 08:11:27 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-7-marcan@marcan.st>
 <20210308203841.GA2906683@robh.at.kernel.org> <87zgzdqnbs.wl-maz@kernel.org>
In-Reply-To: <87zgzdqnbs.wl-maz@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 9 Mar 2021 09:11:15 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJVmr+23HDN-7Wjbrkh5jt=4dbU9y1iUqDu1nPOV2+38Q@mail.gmail.com>
Message-ID: <CAL_JsqJVmr+23HDN-7Wjbrkh5jt=4dbU9y1iUqDu1nPOV2+38Q@mail.gmail.com>
Subject: Re: [RFT PATCH v3 06/27] dt-bindings: timer: arm,arch_timer: Add
 interrupt-names support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 8, 2021 at 3:42 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 08 Mar 2021 20:38:41 +0000,
> Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Mar 05, 2021 at 06:38:41AM +0900, Hector Martin wrote:
> > > Not all platforms provide the same set of timers/interrupts, and Linux
> > > only needs one (plus kvm/guest ones); some platforms are working around
> > > this by using dummy fake interrupts. Implementing interrupt-names allows
> > > the devicetree to specify an arbitrary set of available interrupts, so
> > > the timer code can pick the right one.
> > >
> > > This also adds the hyp-virt timer/interrupt, which was previously not
> > > expressed in the fixed 4-interrupt form.
> > >
> > > Signed-off-by: Hector Martin <marcan@marcan.st>
> > > ---
> > >  .../devicetree/bindings/timer/arm,arch_timer.yaml  | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
> > > index 2c75105c1398..ebe9b0bebe41 100644
> > > --- a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
> > > +++ b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
> > > @@ -34,11 +34,25 @@ properties:
> > >                - arm,armv8-timer
> > >
> > >    interrupts:
> > > +    minItems: 1
> > > +    maxItems: 5
> > >      items:
> > >        - description: secure timer irq
> > >        - description: non-secure timer irq
> > >        - description: virtual timer irq
> > >        - description: hypervisor timer irq
> > > +      - description: hypervisor virtual timer irq
> > > +
> > > +  interrupt-names:
> > > +    minItems: 1
> > > +    maxItems: 5
> > > +    items:
> > > +      enum:
> > > +        - phys-secure
> > > +        - phys
> > > +        - virt
> > > +        - hyp-phys
> > > +        - hyp-virt
> >
> > phys-secure and hyp-phys is not very consistent. secure-phys or sec-phys
> > instead?
> >
> > This allows any order which is not ideal (unfortunately json-schema
> > doesn't have a way to define order with optional entries in the middle).
> > How many possible combinations are there which make sense? If that's a
> > reasonable number, I'd rather see them listed out.
>
> The available of interrupts are a function of the number of security
> states, privileged exception levels and architecture revisions, as
> described in D11.1.1:
>
> <quote>
> - An EL1 physical timer.
> - A Non-secure EL2 physical timer.
> - An EL3 physical timer.
> - An EL1 virtual timer.
> - A Non-secure EL2 virtual timer.
> - A Secure EL2 virtual timer.
> - A Secure EL2 physical timer.
> </quote>
>
> * Single security state, EL1 only, ARMv7 & ARMv8.0+ (assumed NS):
>   - physical, virtual
>
> * Single security state, EL1 + EL2, ARMv7 & ARMv8.0 (assumed NS)
>   - physical, virtual, hyp physical
>
> * Single security state, EL1 + EL2, ARMv8.1+ (assumed NS)
>   - physical, virtual, hyp physical, hyp virtual
>
> * Two security states, EL1 + EL3, ARMv7 & ARMv8.0+:
>   - secure physical, physical, virtual
>
> * Two security states, EL1 + EL2 + EL3, ARMv7 & ARMv8.0
>   - secure physical, physical, virtual, hyp physical
>
> * Two security states, EL1 + EL2 + EL3, ARMv8.1+
>   - secure physical, physical, virtual, hyp physical, hyp virtual
>
> * Two security states, EL1 + EL2 + S-EL2 + EL3, ARMv8.4+
>   - secure physical, physical, virtual, hyp physical, hyp virtual,
>     secure hyp physical, secure hyp virtual
>
> Nobody has seen the last combination in the wild (that is, outside of
> a SW model).
>
> I'm really not convinced we want to express this kind of complexity in
> the binding (each of the 7 cases), specially given that we don't
> encode the underlying HW architecture level or number of exception
> levels anywhere, and have ho way to validate such information.

Actually, we can simplify this down to 2 cases:

oneOf:
  - minItems: 2
    items:
      - const: phys
      - const: virt
      - const: hyp-phys
      - const: hyp-virt
  - minItems: 3
    items:
      - const: sec-phys
      - const: phys
      - const: virt
      - const: hyp-phys
      - const: hyp-virt
      - const: sec-hyp-phy
      - const: sec-hyp-virt

And that's below my threshold for not worth the complexity.

Rob
