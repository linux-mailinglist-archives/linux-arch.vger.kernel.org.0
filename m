Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEAA78B73D
	for <lists+linux-arch@lfdr.de>; Mon, 28 Aug 2023 20:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjH1ScZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Aug 2023 14:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjH1ScQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Aug 2023 14:32:16 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF2AB9;
        Mon, 28 Aug 2023 11:32:14 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1c26bb27feeso2557144fac.0;
        Mon, 28 Aug 2023 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693247534; x=1693852334;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cYaqHdJguh90lafMBaasjNFY4ARPGILI9uHRSPA4ax0=;
        b=WaN1WnyIpgFgFrSnbiC+pmTNY+frEr0GkIEolN7JLhgfXZKyX/rwMPyfAiAoieu30l
         Ymxt5je2MV7wOdBK1S0z9WKckbxpHd0SOcuBurD6lLYFiwJp6BLrolHlbRi2pCuMVBPg
         hby6/zEF36UVyG1uVrk50FPOnt8shrUC/g+QF40H+bb7M2xYS0GmqX/knUgIOn06zI0J
         mY+bJJ/graQm8+XS8JeFhCIuLlz4jROAoGCak9TalWjfxrBVhdmvdD6eAclRP873Jgqc
         uvb344LLVkgA+eDhNGMvs9uCbP9oLUGMae+hLA6TPDEcqQCH5zLxJ8OKHffQc/x0h78G
         4Q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693247534; x=1693852334;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYaqHdJguh90lafMBaasjNFY4ARPGILI9uHRSPA4ax0=;
        b=YFvr4h3eblPofRWyFX7rkDEL5mXKFRzikt8s4IH5bekpQx3lZKkYHT+a8xSu0QKhnt
         GE8jNzk2UdENWxcb7UxhH1iyTWUhcQ6JveB/3E+NdklOKukOCAJlLCPtJRbOjWPFwz+Z
         Nv8QNC1Xhosws5qsbTa8v5iDrscXYTh9etofkLLDNObAylX3PTPKOuD5QiXTud5P2BUG
         8hnc2Q1K3QfvT4RKFXMvt2p7u3/K84S9Ef7mRDEFs2P4r/dxSkfVnMO+eWUDbyhFcJXA
         oa8+CVYwON+ZpZb5O6bokVaoJXHk4Ci2OT29ledz3DzRrCj0KmiYCzeUyaeMXegXzc6W
         K/ww==
X-Gm-Message-State: AOJu0Yy2m4Ea+wiSatEJglp0wyG3psIJRMUiLW9Bu65V+MBBy70VLagw
        bpA6D3MTArbKMaVUke+Xkrht21Y95e+DMD5GR74A9rWN
X-Google-Smtp-Source: AGHT+IHUPTewo1PRtYNHwfExAdqJdNNvUQ3kkD61NwAtILCe0SKA7kIknktEZiR1TY+D+exvLpENJ+3DM0TalR+wGPk=
X-Received: by 2002:a05:6870:b624:b0:1c6:ac86:d56 with SMTP id
 cm36-20020a056870b62400b001c6ac860d56mr13305221oab.14.1693247533710; Mon, 28
 Aug 2023 11:32:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:1141:0:b0:4f0:1250:dd51 with HTTP; Mon, 28 Aug 2023
 11:32:13 -0700 (PDT)
In-Reply-To: <CAHk-=wgrsfz4HmJE2fgdHrh-xUuVqk7t08=k2scz8Cgix0hBwg@mail.gmail.com>
References: <20230828170732.2526618-1-mjguzik@gmail.com> <CAHk-=wi1BO1KQaPOTzs7N4QrLh2UCiRuNnW0MPVTDLrRxZhDww@mail.gmail.com>
 <CAGudoHGGXNP5dBpZLadBUTVeD-JPEuikQXONruJzvnRJrp5+KA@mail.gmail.com> <CAHk-=wgrsfz4HmJE2fgdHrh-xUuVqk7t08=k2scz8Cgix0hBwg@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Mon, 28 Aug 2023 20:32:13 +0200
Message-ID: <CAGudoHF6T5SCE0Tn9=YUOV9ZcbQOSUe9Z=0tNbf72yvNqmP0oQ@mail.gmail.com>
Subject: Re: [PATCH] x86: bring back rep movsq for user access on CPUs without ERMS
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/28/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Mon, 28 Aug 2023 at 11:04, Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> Other files do it (e.g., see __copy_user_nocache), but I have no
>> strong opinion myself.
>
> So the __copy_user_nocache() thing is a case of that second issue -
> see my comment about "some sane visually sensible grouping" of the
> numbers.
>
> Look closer, and you'll notice that they aren't actually sequential.
> They are of the form XY where the X is the grouping, and Y is the
> local number within that grouping.
>
> That case also comes with a fair amount of comments about each group
> for the extable entries.
>
> But yes, we also do have a number of thos e"sequential labels". See
> for example arch/x86/lib/getuser.S, where we then end up having all
> the exception handling at the end because it is mostly shared across
> cases. It's ugly.
>
> We also have a lot of ugly cases that probably shouldn't use numbers
> at all, eg csum_partial(). I think that goes back to some darker age
> when things like "assembly is so trivial that it doesn't need any
> fancy explanatory labels for code" was ok.
>
> See also arch/x86/lib/memmove_64.S for similar horrors. I wonder if it
> is a case of "use compiler to get almost the right code, then massage
> things manually". Nasty, nasty. That should use legible names, not
> random numbers.
>
> I also suspect some people really thought that the numbers need to be
> unique, and just didn't know to use local numbering.
>

That was bad example, I meant stuff was already *unique* in other
files and it is sequential in some of them. In the very func I'm
modifying here there is 0/1 followed by 2/3 pair already, so it looked
like the convention to follow.

Anyhow this is bullshit detail I'm not going to argue about, you made
your position clear and I see no problem adhering to it -- consider
this bit patched in v2.

Can we drop this aspect please ;)

-- 
Mateusz Guzik <mjguzik gmail.com>
