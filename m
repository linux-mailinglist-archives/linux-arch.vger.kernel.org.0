Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C644C00AB
	for <lists+linux-arch@lfdr.de>; Tue, 22 Feb 2022 18:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbiBVR5o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Feb 2022 12:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbiBVR5m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Feb 2022 12:57:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F046E9F3AC
        for <linux-arch@vger.kernel.org>; Tue, 22 Feb 2022 09:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645552632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hJzZgeDzNY7zmhhmPD8Ts6QhadgVuW+LtnZrIEdFmk4=;
        b=dzhLqdcCZ+v0UEC8Rvd8QMlBU2yb+DBopO06Pqc4uVxV83lzhdMysU004Wq5Ah4epxHexq
        vsgtBn4GCWkxLnGHvgwWyVWDHMPvqgnOGvE3Vx820+RFsZ62dBQCQep/zUni0BX1N4bGHX
        K/pt2UgjEsrcgiNFBsk+Wg4pbq0Gcg8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-3aqusp7eOXCJaAxjKcIc-g-1; Tue, 22 Feb 2022 12:57:08 -0500
X-MC-Unique: 3aqusp7eOXCJaAxjKcIc-g-1
Received: by mail-wr1-f70.google.com with SMTP id f14-20020adfc98e000000b001e8593b40b0so8564049wrh.14
        for <linux-arch@vger.kernel.org>; Tue, 22 Feb 2022 09:57:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hJzZgeDzNY7zmhhmPD8Ts6QhadgVuW+LtnZrIEdFmk4=;
        b=Rt5wkkNch0sFqNHNZ4+QoNu6jlrNTbeIXlpfTGeeh7lfehIIMLSLgWrtwwZ7ocl6gz
         rhncsPEveNy6lb9+pm3/DbYjEvvhpSJ3YNxtRmxmkhTQENZGy7vBfeJK+2l7jMqlEK+U
         tcWXaGD05F+R3RMlnqquQ8r9fSYxaZBz8M4cx22j6zaFteSXH6DPL63Vkc88z4hcLA4u
         abmbw8C4LP+NoRSV0eqYtXxAjojWWID66nrp3ptb8DxWuN3CnUiOCvLVvJp0P9RjQqXC
         1X3Yv0nILG3M8wLwzkrhDxrdxJ+j+fyahTf6NF9U+gkt+kbpsRwNRL2qZnM3Tc65+fO5
         k2Gw==
X-Gm-Message-State: AOAM533xOyCrzHjttcHgwCyDMdBzww/icyTGldhDuNjSGat4e9KNo0Vu
        2//mULuDusDS0Xa3KevTQgtsI4fw20xqDIcz2m+cI6dNTUEMUD+9wVyOIsU3zFwQsOc+z24Ro4t
        U0CXqQYoOkxYbBV6w3IOo
X-Received: by 2002:adf:e10a:0:b0:1e3:3188:79c7 with SMTP id t10-20020adfe10a000000b001e3318879c7mr20431441wrz.329.1645552626669;
        Tue, 22 Feb 2022 09:57:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBLqieyLWhR9YxZvOyFiDe21CGa5pv2+OROhVCjx6WLj1pEI28rUPcGkTq6FUILDxoAizVhQ==
X-Received: by 2002:adf:e10a:0:b0:1e3:3188:79c7 with SMTP id t10-20020adfe10a000000b001e3318879c7mr20431432wrz.329.1645552626509;
        Tue, 22 Feb 2022 09:57:06 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id e7sm33021244wrg.44.2022.02.22.09.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 09:57:06 -0800 (PST)
Date:   Tue, 22 Feb 2022 17:57:05 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH v5 1/6] module: Always have struct mod_tree_root
Message-ID: <20220222175705.ryqmhhrpokx7xbgv@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <cover.1645541930.git.christophe.leroy@csgroup.eu>
 <c9584f48abce748e62e65e6757ceb23800f15380.1645541930.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9584f48abce748e62e65e6757ceb23800f15380.1645541930.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue 2022-02-22 16:00 +0100, Christophe Leroy wrote:
> In order to separate text and data, we need to setup
> two rb trees.
> 
> This means that struct mod_tree_root is required even without
> MODULES_TREE_LOOKUP.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  kernel/module/internal.h | 4 +++-
>  kernel/module/main.c     | 5 -----
>  2 files changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin

