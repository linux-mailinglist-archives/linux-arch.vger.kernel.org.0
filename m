Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED167A2BD8
	for <lists+linux-arch@lfdr.de>; Sat, 16 Sep 2023 02:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjIPAVg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 20:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238184AbjIPAU4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 20:20:56 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F423ABB
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 17:18:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-501bd7711e8so4361031e87.1
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 17:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694823371; x=1695428171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zporDHrE3+uyIwe+VfbiYR93jfa43r8rLTR9B3l5F9o=;
        b=FGtUYMjDUo/vxqvnL/p+dNQbjJOsMfDK3U2ckYlvp+9DYiXRDoWIjEBXh6VR3StVHn
         G4FTwxGQZ5GWYbDk+lk+BbGQ21FXo///kUv29067Gbg334dPOnB7HfYS70gnDDIfTnmO
         JJ7WKakV/+f4qF+M7EWaRFP+WW16+8Z+GnYEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694823371; x=1695428171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zporDHrE3+uyIwe+VfbiYR93jfa43r8rLTR9B3l5F9o=;
        b=Noi0xoZhd10NpvrhBIjYYQjbmtD0jp4t5maItwE22laCdwgedibntB6EIWYKQS3nWv
         CTIYLCYFw/IcZSTI52mcZt1RLProNpRwrVWDuDMR2A8nD8eGtJK5LIVyG69Ef7FKFoGz
         fHBYt75fxonaTOrITYHrrOlPh0NF03FhPL+EEDD/mmC2AKP60pTESC647YEChoMzDqQM
         8K1k1eYqvW58xwSerU9TrW3XPW1ro3iiOKOAmTEktbTjV/QCyg9WCHzSYCdXUA9pcxjx
         js+f5+AH7vWL46Z/0u5Sq0MAbGElaJxAFoKEfvx+K2o9BTNerBG6zRiwyfqFGa6gojQt
         sm/w==
X-Gm-Message-State: AOJu0YxJOIPKuybEx494mZ4gRGCDXvbeegfZ6DAoHKLYtWm70svrYy8p
        NWjJOdxccFZu2bF8K1v2BK8nwq5QOo8hY0a6hpAbcIlk
X-Google-Smtp-Source: AGHT+IEbpk2hFvyqgONMuEi5zLEevYlUAT0TfQSyJVgy3+JCTz9lHTgiA1y6FIBKQnrGnDcrUY5lfA==
X-Received: by 2002:a19:4f08:0:b0:500:dc8d:c340 with SMTP id d8-20020a194f08000000b00500dc8dc340mr2616882lfb.35.1694823370861;
        Fri, 15 Sep 2023 17:16:10 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id c19-20020a197613000000b0050294074233sm796857lff.225.2023.09.15.17.16.10
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 17:16:10 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-500913779f5so4362749e87.2
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 17:16:10 -0700 (PDT)
X-Received: by 2002:a05:6512:3113:b0:500:bc14:3e06 with SMTP id
 n19-20020a056512311300b00500bc143e06mr2583654lfb.44.1694823369876; Fri, 15
 Sep 2023 17:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183707.2707298-1-willy@infradead.org> <20230915183707.2707298-3-willy@infradead.org>
 <CAHk-=wh4=cYh5OC5PiiX_nAQkyViXL21bpmaARduGOLiOOgTyw@mail.gmail.com>
In-Reply-To: <CAHk-=wh4=cYh5OC5PiiX_nAQkyViXL21bpmaARduGOLiOOgTyw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 17:15:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqZqTYunL-0tn2-khCU1rcZDrTvY4cdFsx_b_bF=xbGw@mail.gmail.com>
Message-ID: <CAHk-=whqZqTYunL-0tn2-khCU1rcZDrTvY4cdFsx_b_bF=xbGw@mail.gmail.com>
Subject: Re: [PATCH 02/17] iomap: Protect read_bytes_pending with the state_lock
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 15 Sept 2023 at 17:11, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
[...]
>         if (unlikely(error))
>                 folio_set_error(folio);
>         else if (uptodate)
>                 folio_mark_uptodate(folio);
>         if (finished)
>                 folio_unlock(folio);
>   }

Note that this then becomes

        if (unlikely(error))
                folio_set_error(folio);
        if (finished)
                folio_unlock(folio, uptodate && !error);
  }

but that change would happen later, in patch 6/17.

             Linus
