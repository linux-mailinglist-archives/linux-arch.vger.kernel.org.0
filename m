Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413485FDEB0
	for <lists+linux-arch@lfdr.de>; Thu, 13 Oct 2022 19:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJMRKw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Oct 2022 13:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJMRKw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Oct 2022 13:10:52 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDD71900E;
        Thu, 13 Oct 2022 10:10:42 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.97.193]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N7zJl-1pElmK1yvz-014zSo; Thu, 13 Oct 2022 19:07:47 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id B53E93C186; Thu, 13 Oct 2022 19:07:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1665680865; bh=nYzni+L9VyrG5x0Rm0GekVqt+5sAuaP0Uw0wWRtznbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YybbEip1ziptyerFZW5x4mHETsrpJ3v3H7/cNimPA9plNumzlqdDT+4GgSMkIrxrI
         YiSjrA7SbDK6Co+Ar4RZP8WqwKv9LSa6jpUtfcvlB/KnUGlPC8UMg7XYEGNLrvOo7W
         mFbducFtcLs8gz7GPbuFq9KttC/1RQYe6LLySJGg=
Date:   Thu, 13 Oct 2022 19:07:45 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: remove special treatment for the link order of
 head.o
Message-ID: <Y0hF4XfsgKxevNzj@fjasle.eu>
References: <20221012233500.156764-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221012233500.156764-1-masahiroy@kernel.org>
X-Provags-ID: V03:K1:nNax0N1B61G4QZH1bsIn90CO6far/9fS9B2aw4JVF3yySGv09F8
 htH/J6uXUBR/KxIOEg++8HQ/B7UxLWVhLs/LtTXBEUpNIj413gwcD6jauODM82IybtVrC8a
 B6+D6kxAVA6xOlngSyPWaL/9YeChjJm7xZ13aeoANMDFqRrs6mQR7hKOX6+7mnebE1Q1RwA
 w1s5qCIrJ1+xko0c0wGFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:62mvNxEj8YQ=:l8rqU7jgDxoy/CFAQjc5Gc
 OU8VTF5vkXhHKJQ5iXYvU1F80n7vU96GDUQ3cXHJfHCnpFzNzJoRtz18EICY+CpsghJ7qoghU
 R46AF6zlBWqe6AXkzEo3qKApUqsdkZTJhX14Ao51hv5UPnrsjh5WXMTmi+/rcK+3wpUPXmf51
 Ara0DAXguWqUIZyCmm5KfSdRciw01FyKeoClJxAjTDZegJL937KqQTkt3fbcWWflSkcKNS86e
 7bKgWDTLm5FJ8GT83pA2wZTz8+EvkpSxhm3tvrbS2NI4ITtDTCUIMMNZcmoh+1jkaBh/PYy0P
 rmyduLA87e4f0sFwY1Z3VAspcFJb4wwCi30SoHGqqSnOun5H+yowP474wBWj6RAJpoqYla4Vw
 +oYg3r8vi0Q10uJmTq4Y2J14fw1DaVF5JPJkUNpNESATSgiaEsyF5vMGA+PqfF6cDs0s3+9/T
 SvJHps014cUh2OUmGlgy39CqHHkegpxLQKjWlQymbxBBRpz7o+UBShlQDIelCPECiNtiY1MiA
 DPPnOLWgxJWc8e/Qt8JTULMhw2aSijtdxWnpKikCdaVO6goAxWQGPia4CXoDCnCki3sEflNVW
 1t/KAZEhQKVZ4DJX+vZZg+Q0iwnKO8fUbveQPhxtBMRLa+VtLrKLYLdC/B4l28xAuD6qZaN42
 OZ7thCbeCa1B/MIr8UcEtVABekioyb3XNfdm5ov6q0WhLEpM7YD/ZbDo/Li1Syyt+9T0RSOU6
 5Urh+G+k9qpYXp+vY1ASa3csUNz3ZkaEar2J8EIquDcSoe7G4CWgwOZaZB3D6TTVq4D+HZH3o
 hz3zoAb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 13, 2022 at 08:35:00AM +0900, Masahiro Yamada wrote:
> Date: Thu, 13 Oct 2022 08:35:00 +0900
> From: Masahiro Yamada <masahiroy@kernel.org>
> To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
>  <will@kernel.org>, linux-arm-kernel@lists.infradead.org
> Cc: linux-arch@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, Masahiro
>  Yamada <masahiroy@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
>  linux-kernel@vger.kernel.org
> Subject: [PATCH] arm64: remove special treatment for the link order of
>  head.o
> Message-Id: <20221012233500.156764-1-masahiroy@kernel.org>
> X-Mailer: git-send-email 2.34.1
> 
> In the previous discussion (see the Link tag), Ard pointed out that
> arm/arm64/kernel/head.o does not need any special treatment - the only
> piece that must appear right at the start of the binary image is the
> image header which is emitted into .head.text.
> 
> The linker script does the right thing to do. The build system does
> not need to manipulate the link order of head.o.
> 
> Link: https://lore.kernel.org/lkml/CAMj1kXH77Ja8bSsq2Qj8Ck9iSZKw=1F8Uy-uAWGVDm4-CG=EuA@mail.gmail.com/
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

>  scripts/head-object-list.txt | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.txt
> index b16326a92c45..f226e45e3b7b 100644
> --- a/scripts/head-object-list.txt
> +++ b/scripts/head-object-list.txt
> @@ -15,7 +15,6 @@ arch/alpha/kernel/head.o
>  arch/arc/kernel/head.o
>  arch/arm/kernel/head-nommu.o
>  arch/arm/kernel/head.o
> -arch/arm64/kernel/head.o
>  arch/csky/kernel/head.o
>  arch/hexagon/kernel/head.o
>  arch/ia64/kernel/head.o
> -- 
> 2.34.1

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
