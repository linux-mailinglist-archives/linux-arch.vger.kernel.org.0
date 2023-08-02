Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB90676D6FF
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 20:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjHBSnH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 14:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHBSnG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 14:43:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9362219A4;
        Wed,  2 Aug 2023 11:43:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 294BC6193C;
        Wed,  2 Aug 2023 18:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B54CC433C7;
        Wed,  2 Aug 2023 18:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691001784;
        bh=8fRBLdjQo/bpSDUEY6i1l9Agd9AktsUVVMZZnpro8uU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xKGG3nZ8vD3ITOUslTtOGT0CBVtVJ03zIlBth6y87t++J8UJa1VqW/DQ+NQRc7AVo
         FM/aUhlIRSY7XDAPgi82lA1wgkDFAVIZzUAfOWZGKCtkdJSLRowYZbtLp0auovJv/6
         Nr9abe3+gEochoAfuEN4x2qqseE2QZ1ViiLa+/40=
Date:   Wed, 2 Aug 2023 11:43:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/38] New page table range API
Message-Id: <20230802114303.49af446e77f00598666a87ef@linux-foundation.org>
In-Reply-To: <20230802151406.3735276-1-willy@infradead.org>
References: <20230802151406.3735276-1-willy@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed,  2 Aug 2023 16:13:28 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> For some reason, I didn't get an email when v5 was dropped from linux-next
> (I got an email from Andrew saying he was going to, but when I didn't get
> the automated emails, I assumed he'd changed his mind).  So here's v6,
> far later than I would have resent it.

Sorry - I try to reduce the amount of email I spray out by reducing it to
a single email.
