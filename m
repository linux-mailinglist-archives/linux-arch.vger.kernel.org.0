Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4233559B674
	for <lists+linux-arch@lfdr.de>; Sun, 21 Aug 2022 23:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiHUVkY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Aug 2022 17:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiHUVkX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Aug 2022 17:40:23 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A211EAC0;
        Sun, 21 Aug 2022 14:40:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gi31so11396623ejc.5;
        Sun, 21 Aug 2022 14:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=/HVT7GUvY6+TC++f6Cv4hO1tp2O629oMpPfXSVwaQLA=;
        b=RYc25A5JuGfMMVdJ6ZPp2v1vj1ITYYM40su+Mx8AMDH/71qTY8ertOPlK0AAIQ2IDu
         8/dGm43sd2YkwsiE1cblpWSTCdyR8ljhEq9x0nb8aTGYgIsizbjtePqiThGgWWXSpvD5
         Xc+zXXpDtFy2Iuspm1xaSe3W/GGiWfERC+9c5/wWQRo44jfDSJ+kfVUSDz0Wu/EfB+x5
         S5IzCDwvRd9bG5EzYtRDwGCiA7Orxynr0gGASF+K90rXZr+8AuwIyaTLZZvFkzRLihdy
         xJoTVeOuMBcr+QzSJmuiCD/UVPc6fFTPQP0mJ5b0uMb2Ip1jgxPHNfQfnsOCv21tANN1
         4ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=/HVT7GUvY6+TC++f6Cv4hO1tp2O629oMpPfXSVwaQLA=;
        b=Pbuk+0sN83YiKYkfEct4uYPHqoSQt+wh94B63xsSzBDot7DRKmsu1jpNfdQmd959cq
         tG80d+v+KXC/IceNqLC6kO4aFGILv2PBofPbXsX93qlAqxZ4Ph9na/OyoINNsvrbxmpv
         x6oxlmUKeWLlwCr47M4Sce683an0E2fs4T7f04NuO7oMGVwDJdUl2EbAM50tky6c4JUV
         lFQjZhFlFlLPdUVSeg7TXG41OR1IK1ofWRCaN07rkLkFJKvQYEp/aHg5QyqKPfglQDU1
         c+sWzqVbymdVt3gt8Kj35M7QCCxG6eoe9bUbFJWej2NPf8Llgz5fg839WW3dlJayLoE7
         XoIg==
X-Gm-Message-State: ACgBeo09KbXLg2IVntqIcGj6PxVExo2pV4rGYK01V1XzJEDSKgrczvi2
        nGI1+7bp5QJP1P3W7W7hK5w=
X-Google-Smtp-Source: AA6agR7jraIuXtLvUo9DatL3q0vu1JyYpWqVhby3TIbGuvaloPALXZSVzPnBmWMoAWvzQF0bKesIHw==
X-Received: by 2002:a17:906:d550:b0:733:8e1a:f7 with SMTP id cr16-20020a170906d55000b007338e1a00f7mr11155721ejc.580.1661118021173;
        Sun, 21 Aug 2022 14:40:21 -0700 (PDT)
Received: from gmail.com (195-38-113-151.pool.digikabel.hu. [195.38.113.151])
        by smtp.gmail.com with ESMTPSA id b2-20020aa7dc02000000b0043a7c24a669sm6959977edu.91.2022.08.21.14.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 14:40:20 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 21 Aug 2022 23:40:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steve French <smfrench@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: strlcpy() notes (was Re: [GIT PULL] smb3 client fixes)
Message-ID: <YwKmQllm8Thr3scO@gmail.com>
References: <CAH2r5mtDFpaAWeGCtrfm_WPM6j-Gkt_O80=nKfp6y39aXaBr6w@mail.gmail.com>
 <CAHk-=wi+xbVq++uqW9YgWpHjyBHNB8a-xad+Xp23-B+eodLCEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi+xbVq++uqW9YgWpHjyBHNB8a-xad+Xp23-B+eodLCEA@mail.gmail.com>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So I despise strlcpy(), but I think strscpy() is kind of broken too.
> For the generic case, it really should have two separate buffer sizes.
> 
>  (2) if you expect the destination buffer contents to be untouched
> past the terminating NUL character, you're simply out of luck
> 
> The strscpy() assumption is that it can arbitrarily write to the
> destination buffer.
> 
> So the best way to think of "strscpy()" is really as a "optimized
> memcpy for strings". That's almost exactly how it acts. It will do a
> memcpy(), but stop when it notices that it has copied a NUL character.

Not to shed-paint this too much, but would it help if the naming reflected 
that property of chunk-size NUL-(over)write a bit better?

- memcpy_str(), memstrcpy(), memscpy(), etc.?

Developers do tend to think differently about operations that are named 
after memcpy(). Here the argument order and semantics are pretty close to 
memcpy() - if the naming is similar, we'd want people to think of it as a 
memcpy(), not a string-copy.

[ Personally I'd prefer memcpy_str(): it's a variant of memcpy() that stops 
  earlier if possible, and does the 'early stop' safely & robustly. ]

Thanks,

	Ingo
