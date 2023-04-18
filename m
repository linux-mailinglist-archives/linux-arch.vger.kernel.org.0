Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F349C6E6E44
	for <lists+linux-arch@lfdr.de>; Tue, 18 Apr 2023 23:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjDRVd0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Apr 2023 17:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjDRVdZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Apr 2023 17:33:25 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F04BAF2D;
        Tue, 18 Apr 2023 14:33:19 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54fa9da5e5bso275696507b3.1;
        Tue, 18 Apr 2023 14:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681853598; x=1684445598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZ+faik75720SnLDzvntxl1cmAaRHsLQ7oOmPoVPf3o=;
        b=fBPSS93aalbav0LUzUejRt2NjbHpBJmNsHVPRRbsF+jG5Nu8WjfWT+weSiXFGrkEbN
         Bl+EcMNC7lpcawm/MuwqggHfJmNk7zAK9haLpnJV08P367c5YohyB4lPm9ubYCuINJZG
         pmhBTFu6UKlSFmyU0QWGBEDpdg/7xojdmyIrq4CWcHgeoPLavovDZAMaCmQm5Tmi+PdF
         awAr9pJ9qRfL4qAoU/GIaaVF0Yb/A9oc1EXdyleFSucNiyAMBSWiFjcubi/Cl7MqSDQT
         LqfYl5LxNuy3TqKDTGZky+Cx6fyOI9+XqrTm2mW88NG+xvACaI/puCphU95FqO3MwFDd
         on2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681853598; x=1684445598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZ+faik75720SnLDzvntxl1cmAaRHsLQ7oOmPoVPf3o=;
        b=aWGt3ryN3Ppg8/UQ/Gpx8SoGMNAtUazbaiRyDmk/+Ya8wZaQMFtC/J1vDYgc37uuxd
         cD2DGBI8Yn9tgC+aT0FMy40DkCzhwPfd9jb5VXMmWUpoNpLGDAOzxFwCoLUpKgeADEtK
         fSovEg38ZkpPr9jZewffRZn7N7Hwobrfqs97iRSVtAOLWZn3YnCiiZyHhEKrHORR4CNw
         YP1iIEvqMzW0oxpKJm5QUE/fOb1Xt93WkY4rKDyFq/zJoyR+cjw7Ldaf/TBfwQH9YjqL
         BfeSxm7FvBzL7wkXbDlreQlNWo/e6qmpayACP2sRUFsoHRm1zu/HeGUVKYR9XiYQYqi6
         FHgg==
X-Gm-Message-State: AAQBX9dnNB+aIEVE1UBPdT3KEpk/1YBOvbnSlZuQwCWomPxbb3dg1c1y
        Ej0oZ8jdgW5yPnGtJXvFu6NWOIX69WGLd8hiX/s=
X-Google-Smtp-Source: AKy350Zg9/w1pIq1h9Mfl98gkIvdjlXYVLE/yxlCrmuaudFEJKPjKGaCNnj1KVCOnrcLYZjlnD0Q2KC4cnvL5HhzBhY=
X-Received: by 2002:a81:8443:0:b0:54f:8af3:6488 with SMTP id
 u64-20020a818443000000b0054f8af36488mr1215032ywf.23.1681853598073; Tue, 18
 Apr 2023 14:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230417205048.15870-1-vishal.moola@gmail.com>
 <20230417205048.15870-2-vishal.moola@gmail.com> <da600570-51c7-8088-b46b-7524c9e66e5d@redhat.com>
In-Reply-To: <da600570-51c7-8088-b46b-7524c9e66e5d@redhat.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Tue, 18 Apr 2023 14:33:06 -0700
Message-ID: <CAOzc2pwpRhNoFbdzdzuvrqbZdf2OsrTvBGs40QCZJjA5fS_q1A@mail.gmail.com>
Subject: Re: [PATCH 01/33] s390: Use _pt_s390_gaddr for gmap address tracking
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 18, 2023 at 8:45=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 17.04.23 22:50, Vishal Moola (Oracle) wrote:
> > s390 uses page->index to keep track of page tables for the guest addres=
s
> > space. In an attempt to consolidate the usage of page fields in s390,
> > replace _pt_pad_2 with _pt_s390_gaddr to replace page->index in gmap.
> >
> > This will help with the splitting of struct ptdesc from struct page, as
> > well as allow s390 to use _pt_frag_refcount for fragmented page table
> > tracking.
> >
> > Since page->_pt_s390_gaddr aliases with mapping, ensure its set to NULL
> > before freeing the pages as well.
> >
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
>
> [...]
>
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 3fc9e680f174..2616d64c0e8c 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -144,7 +144,7 @@ struct page {
> >               struct {        /* Page table pages */
> >                       unsigned long _pt_pad_1;        /* compound_head =
*/
> >                       pgtable_t pmd_huge_pte; /* protected by page->ptl=
 */
> > -                     unsigned long _pt_pad_2;        /* mapping */
> > +                     unsigned long _pt_s390_gaddr;   /* mapping */
> >                       union {
> >                               struct mm_struct *pt_mm; /* x86 pgds only=
 */
> >                               atomic_t pt_frag_refcount; /* powerpc */
>
> The confusing part is, that these gmap page tables are not ordinary
> process page tables that we would ordinarily place into this section
> here. That's why they are also not allocated/freed using the typical
> page table constructor/destructor ...

I initially thought the same, so I was quite confused when I saw
__gmap_segment_gaddr was using pmd_pgtable_page().

Although they are not ordinary process page tables, since we
eventually want to move them out of struct page, I think shifting them
to be in ptdescs, being a memory descriptor for page tables, makes
the most sense.

Another option is to leave pmd_pgtable_page() as is just for this case.
Or we can revert commit 7e25de77bc5ea which uses the function here
then figure out where these gmap pages table pages will go later.
