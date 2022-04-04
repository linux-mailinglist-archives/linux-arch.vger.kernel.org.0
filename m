Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525F34F1D40
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 23:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380324AbiDDVae (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 17:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379582AbiDDRgc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 13:36:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E61286E7
        for <linux-arch@vger.kernel.org>; Mon,  4 Apr 2022 10:34:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gt4so3552843pjb.4
        for <linux-arch@vger.kernel.org>; Mon, 04 Apr 2022 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V1fiQ+TpCWz9aW9batEAHSpfr5r9dyK3Q/lTwaH3lR0=;
        b=n5mRgSQ8y20acZ/nK6OhYxxGJzwZSGfgcaIV5gwWcarOIpZUaCExb23hDcba/FfujR
         xFNvpv34nq2Hj6fGtwvQQenG/CsfvSWly7w85pOa2sG503FmKvshqI9P5cFMoVE3Aar/
         UQu5P8WN1WRQr6qVnpL2fGXvjFr5cmxhUxxebpUNcv68zXidJPUkPwuQpB2cgSdry9M0
         eLkTMCOhfou4kVQgZxaauYZqxvKoMSlmivMsJ7IiJDCkOcBgoxX2LkJHmM3A/XGrPuQZ
         2pPiCkDFuX+TqlPuqM3RY9B1nPG/O5uu9L/f2k9jXWu9RJ6qGXKz05KdOk77e14RcYjY
         VMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V1fiQ+TpCWz9aW9batEAHSpfr5r9dyK3Q/lTwaH3lR0=;
        b=FI7nWpAv607lQTOjbF+BBKbr/wPtnzjJNtlkQysulpWCsLYOD2uXegCVhT1WP1jz1F
         MVF18+VcZ+FsDEA71maZgN696V0gRWBD7K+jJw02tRnYUOxGOT8/Nd0WefwKgWi5vUvU
         R1COupYlFOM4ZRhX+ffHrMeUllqrWSMUbLZkoOp0AXgIpdDmvFVgt/VJb/s1NvnD814r
         8mTW/EnO7gs4tbb8mqirPd4JbIj7paYrJRxVyIwG8bJgdOBnhsp1C0r56BGTpWqlcXY7
         JuTgyafA1w4uL6FSXnEyzxXPxBxWxBKP3tSSF3UNGqf06KNRvembCGNUWZqe4QqhlkHH
         IhYQ==
X-Gm-Message-State: AOAM530wyJbx7aXerJG+GRJaSPJW6P/yM8diQxECNAFRovjsnyIuzG/n
        UIrGVi5Uq62nU2rNLiv1VtEAXg==
X-Google-Smtp-Source: ABdhPJwHq/HMWfqJNWl3Tmj7ZD7tbsm4BjEdWB/ICSYcy3kVA2KslfNYCV0z25OGCfSV48YcTJj1nA==
X-Received: by 2002:a17:903:20c:b0:154:b58:d424 with SMTP id r12-20020a170903020c00b001540b58d424mr704902plh.45.1649093675449;
        Mon, 04 Apr 2022 10:34:35 -0700 (PDT)
Received: from google.com ([2620:15c:211:202:9d5:9b93:ffb4:574a])
        by smtp.gmail.com with ESMTPSA id f66-20020a62db45000000b004fa8a7b8ad3sm12748136pfg.77.2022.04.04.10.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:34:34 -0700 (PDT)
Date:   Mon, 4 Apr 2022 10:34:27 -0700
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/8] kbuild: prevent exported headers from including
 <stdlib.h>, <stdbool.h>
Message-ID: <YkssI2uDHRq41zjw@google.com>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-3-masahiroy@kernel.org>
 <YkqhQhJIQEL2qh8C@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkqhQhJIQEL2qh8C@infradead.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 04, 2022 at 12:41:54AM -0700, Christoph Hellwig wrote:
> On Mon, Apr 04, 2022 at 03:19:42PM +0900, Masahiro Yamada wrote:
> > If we can make kernel headers self-contained (that is, none of exported
> > kernel headers includes system headers), we will be able to add the
> > -nostdinc flag, but that is much far from where we stand now.

This is something I'd like to see done. IMO, the kernel headers should
be the independent variable of which the libc is the dependendent
variable.

Android's libc, Bionic, is making use of the UAPI headers. They are
doing some rewriting of UAPI headers, but I'd like to see what needs to
be upstreamed from there. I just noticed
include/uapi/linux/libc-compat.h, which seems like a good place for such
compat related issues.

In particular, having UAPI_HEADER_TESTS depend on CC_CAN_LINK is
something I think we can works towards removing. The header tests
themselves don't link; they force a dependency on a prebuilt libc
sysroot, and they only need the headers from the sysroot because of this
existing circular dependency between kernel headers and libc headers.

I'd be happy to be explicitly cc'ed on changes like this series, going
forward. Masahiro, if there's parts you'd like me to help with besides
just code review, please let me know how I can help.

> 
> What is still missing for that?
