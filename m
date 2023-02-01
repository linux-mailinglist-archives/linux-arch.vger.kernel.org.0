Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5B867BD74
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 21:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbjAYUzW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 15:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbjAYUzV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 15:55:21 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A3C4A1F9
        for <linux-arch@vger.kernel.org>; Wed, 25 Jan 2023 12:55:19 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id y8so6338vsq.0
        for <linux-arch@vger.kernel.org>; Wed, 25 Jan 2023 12:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GW5QetboOjp/W1DGCPKlZRb9/ODQzueiI/Kp5ewpL8w=;
        b=q1Y43sVBV67a+pTMXgzYdcgrIM1+jDEVyQDrYIY2VqgPCBA4gLIrVelM5WvsaRU6FT
         apqIDYl5nTydWmXdWFsHHzEmnUi9ucbdv/eGaDFY+/ikPxP7rpgjg23TSKdKRNG75RfF
         hOJWv6YDiJCYWInMiKfmSvisKfQHceB412aHHLyIH4laJZDnAhdUA/gwrmMFaTmYP4wI
         JasXHanhpujv7dWFati3LIBFZ6AJQSVfl11oMManr2Pa9YA9E34Bt+wQcOsCwX3M2nO1
         aPfT/BNnaT1wPwl1xWgGhrkDfqq/B+t3Phb8hSkCfWokWCUfGMVgTTrWzsij4Z4mDYa4
         4IoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GW5QetboOjp/W1DGCPKlZRb9/ODQzueiI/Kp5ewpL8w=;
        b=dV8N4JI4sUJuIq1wMttvjm8LAtBkFnhD0i4b9WSH2SOTdbL/DLX9lUEEFdz8iIzSU9
         D6tiwxK2xazy74AEKQVR4nPuJwYiPPt5dhfgWhO0jzqEuUMa6sNYO8nVQKmL6tsDxUgg
         EPBqQL7BTWa14QrGzgzemKphky0DXMorh7/1CJQ8nco6Qc45LwcVLeSFSjlRCUERd/kH
         zg6xrZBZKk46pikhsH16UTMXqXbtjTZ+eWFHgHdKVmNu+Ilk+8Ez94tSPk+VyR8C3ebO
         8VXU4eFz4SRtTew463H7QmKNzxT3M9XLrCitE7l/LkSpzR14tDkWw/P7yqX1/s+iD7hZ
         upnA==
X-Gm-Message-State: AFqh2krvQfS+iyQ8GROJnEttX/mmHINkwU5a78/Gn/suC3nVEElU9IqQ
        UrMFIRqWAwK/an9PNvsdpPIlopk42qeE79jkf8Zmpg==
X-Google-Smtp-Source: AMrXdXviSBQt/EVgkIYc2P8tOGvMYorzKUR4KlpF038mvQhGE7AGWByUE0GqDBCYz0ZD4Keh/l4cAHpGGwW9DuqqjQA=
X-Received: by 2002:a67:f650:0:b0:3d3:db6b:e761 with SMTP id
 u16-20020a67f650000000b003d3db6be761mr4768562vso.46.1674680118522; Wed, 25
 Jan 2023 12:55:18 -0800 (PST)
MIME-Version: 1.0
References: <167467815773.463042.7022545814443036382.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167467815773.463042.7022545814443036382.stgit@dwillia2-xfh.jf.intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 25 Jan 2023 13:54:42 -0700
Message-ID: <CAOUHufashDpjnj=XxaR3jsAxPT6tOuv+Uv9ZuJ_8=vLS_HrDWw@mail.gmail.com>
Subject: Re: [PATCH v2] nvdimm: Support sizeof(struct page) > MAX_STRUCT_PAGE_SIZE
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     nvdimm@lists.linux.dev, stable@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 25, 2023 at 1:23 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Commit 6e9f05dc66f9 ("libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE")
>
> ...updated MAX_STRUCT_PAGE_SIZE to account for sizeof(struct page)
> potentially doubling in the case of CONFIG_KMSAN=y. Unfortunately this
> doubles the amount of capacity stolen from user addressable capacity for
> everyone, regardless of whether they are using the debug option. Revert
> that change, mandate that MAX_STRUCT_PAGE_SIZE never exceed 64, but
> allow for debug scenarios to proceed with creating debug sized page maps
> with a compile option to support debug scenarios.
>
> Note that this only applies to cases where the page map is permanent,
> i.e. stored in a reservation of the pmem itself ("--map=dev" in "ndctl
> create-namespace" terms). For the "--map=mem" case, since the allocation
> is ephemeral for the lifespan of the namespace, there are no explicit
> restriction. However, the implicit restriction, of having enough
> available "System RAM" to store the page map for the typically large
> pmem, still applies.
>
> Fixes: 6e9f05dc66f9 ("libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE")
> Cc: <stable@vger.kernel.org>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Marco Elver <elver@google.com>
> Reported-by: Jeff Moyer <jmoyer@redhat.com>

Thanks -- that BUILD_BUG_ON() has been a nuisance for some of my debug configs.

Acked-by: Yu Zhao <yuzhao@google.com>
