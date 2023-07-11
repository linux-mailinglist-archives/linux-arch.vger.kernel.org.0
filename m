Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2C774ED1B
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 13:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjGKLol (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 07:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjGKLok (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 07:44:40 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C1E1A3
        for <linux-arch@vger.kernel.org>; Tue, 11 Jul 2023 04:44:36 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7948ad98b85so1488787241.1
        for <linux-arch@vger.kernel.org>; Tue, 11 Jul 2023 04:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689075876; x=1691667876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98Vqj/PZxHhgJp8IaUkd9tg1OBQKmRK3VTsFucX1JOw=;
        b=sVAx6+85Hh04vCyvrIioS6t4XJqzfw+OmWKG5OnYOj744S63r2cehIEOoZeh9Rv3LJ
         Tx1LSFRvGj6+dORT1tuzSX2fZjyj64RN2w9YaHoD8jyKzVLMbAluBNhCLsgh7+3Mquqs
         tktjtL+IIqZMFXtE1jIAVqScLkVk+qnqFVs6WkBQ1uZamTbYprxFmzr4AMIfovDv4QBr
         bVFZbA6uh4TOa+ltlh6jBfAwtJg+AiVz4FsHk34WW+3bzY5rNgoTrwZF24N55R92M2gz
         jfSFUiC5c/IgAHcpFOo6YZeOpiO+IR2JRUd8AY5WdVEgkGgVcFbWaQK5TWUnvxSgT0QZ
         5Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689075876; x=1691667876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98Vqj/PZxHhgJp8IaUkd9tg1OBQKmRK3VTsFucX1JOw=;
        b=Zw7Nvff5usJc/1egNhyXcN7xmuUhPgr/O/hI7/GfsCh4B7yA4myMcVfQxnCYNAo2nZ
         sCY2RdyciZHBzFGTQXRwQHTATiLRAoLtj6UHPaY0Unu0kUb0Sf7DOg06+FQUdtBd3hZz
         plleanrPl6RboIrpSh3gcEmiBE2GNDeLSyc3gQ/ZzfWqqX17EUNVtMVaKP0bQ5CXGLKN
         T0PIAEceRI6WYl+rtbBZ6ZVcXZTuFkhb+iNxsomA30KxQCDivkydXWD5tQdiGbU0UcZS
         V32I2hL2Fcke392SjTsaz8tX52siS3sS7vjYGlwVO/ibvaDcK6LFHZYNk6Oot7dIHdNd
         YeNw==
X-Gm-Message-State: ABy/qLZpeNc/I9x+H/dshLdm4KaCgxJsmPTvcbPgsepSLwmZ0thN+FnG
        6TOGze/vAsjP68YrnslnPyRRTOzsLo/ItilvIXiGSg==
X-Google-Smtp-Source: APBJJlGngT3Ay/GzMB2GM2l0oaJ3GDslGmMYOcBaB616j11V0rK0orDvSgdISArPnPY6/UzMJis9D0Y2uFsOwhF9EHM=
X-Received: by 2002:a05:6102:34c2:b0:440:d3f0:b516 with SMTP id
 a2-20020a05610234c200b00440d3f0b516mr4386817vst.25.1689075875583; Tue, 11 Jul
 2023 04:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230710223304.1174642-1-almasrymina@google.com>
 <20230710223304.1174642-2-almasrymina@google.com> <f19a7b31-a87e-56d1-c084-2bdb3e1e5a2c@amd.com>
In-Reply-To: <f19a7b31-a87e-56d1-c084-2bdb3e1e5a2c@amd.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 11 Jul 2023 04:44:24 -0700
Message-ID: <CAHS8izNRfcdQOUyOtprxtwo_XE2piw6X_ALsb+REJrHB_t8KXg@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] dma-buf: add support for paged attachment mappings
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>, logang@deltatee.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 11, 2023 at 12:59=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 11.07.23 um 00:32 schrieb Mina Almasry:
> > Currently dmabuf p2p memory doesn't present itself in the form of struc=
t
> > pages and the memory can't be easily used with code that expects memory
> > in that form.
>
> Well, this won't fly at all.
>
> First of all DMA-buf is *not* about passing struct pages around, drivers
> are *only* supposed to use the DMA addresses.
>
> That code can't use the pages inside a DMA-buf is absolutely
> intentional. We even mangle the page pointers from the sg_tables because
> people sometimes get the impression they can use those.
>
> See function mangle_sg_table() in dma-buf.c
>
>          /* To catch abuse of the underlying struct page by importers mix
>           * up the bits, but take care to preserve the low SG_ bits to
>           * not corrupt the sgt. The mixing is undone in __unmap_dma_buf
>           * before passing the sgt back to the exporter. */
>          for_each_sgtable_sg(sg_table, sg, i)
>                  sg->page_link ^=3D ~0xffUL;
>
> > Add support for paged attachment mappings. We use existing
> > dmabuf APIs to create a mapped attachment (dma_buf_attach() &
> > dma_buf_map_attachment()), and we create struct pages for this mapping.
> > We write the dma_addr's from the sg_table into the created pages.
>
> Hui, what? Not really.
>

Thanks for talking a look Christian,

FWIW, the patch doesn't try to use the pages backing the sg_table at
all. The patch allocates pages here:

+       priv->pages =3D kvmalloc_array(priv->num_pages, sizeof(struct page)=
,
+                                    GFP_KERNEL);

And writes the dma_addrs to the pages here:

+       /* write each dma addresses from sgt to each page */
+       pg_idx =3D 0;
+       for_each_sgtable_dma_sg(priv->sgt, sg, i) {
+               size_t len =3D sg_dma_len(sg);
+               dma_addr_t dma_addr =3D sg_dma_address(sg);
+
+               BUG_ON(!PAGE_ALIGNED(len));
+               while (len > 0) {
+                       priv->pages[pg_idx].zone_device_data =3D (void *)dm=
a_addr;
+                       pg_idx++;
+                       dma_addr +=3D PAGE_SIZE;
+                       len -=3D PAGE_SIZE;
+               }
+       }

But, from your response it doesn't seem like it matters. It seems
you're not interested in creating struct pages for the DMA-buf at all.
My options for this RFC are:

1. Use p2pdma so I get struct pages for the device memory, or
2. Modify the page_pool, networking drivers, and sk_buff to use
dma_addr instead of a struct page.

As far as I understand option #2 is not feasible or desired. I'll do
some homework to investigate the feasibility of using p2pdma instead,
and CCing the maintainers of p2pdma. The cover letter of the RFC is
here:

https://lore.kernel.org/netdev/20230710223304.1174642-1-almasrymina@google.=
com/

If there is something obvious to you that is blocking utilizing p2pdma
for this work, please do let me know.

> Regards,
> Christian.
>
>
> >   These
> > pages can then be passed into code that expects struct pages and can
> > largely operate on these pages with minimal modifications:
> >
> > 1. The pages need not be dma mapped. The dma addr can be queried from
> >     page->zone_device_data and used directly.
> > 2. The pages are not kmappable.
> >
> > Add a new ioctl that enables the user to create a struct page backed
> > dmabuf attachment mapping. This ioctl returns a new file descriptor
> > which represents the dmabuf pages. The pages are freed when (a) the
> > user closes the file, and (b) the struct pages backing the dmabuf are
> > no longer in use. Once the pages are no longer in use, the mapped
> > attachment is removed.
> >
> > The support added in this patch should be generic - the pages are creat=
ed
> > by the base code, but the user specifies the type of page to create usi=
ng
> > the dmabuf_create_pages_info->type flag. The base code hands of any
> > handling specific to the use case of the ops of that page type.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > ---
> >   drivers/dma-buf/dma-buf.c    | 223 ++++++++++++++++++++++++++++++++++=
+
> >   include/linux/dma-buf.h      |  90 ++++++++++++++
> >   include/uapi/linux/dma-buf.h |   9 ++
> >   3 files changed, 322 insertions(+)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index aa4ea8530cb3..50b1d813cf5c 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -22,6 +22,7 @@
> >   #include <linux/module.h>
> >   #include <linux/seq_file.h>
> >   #include <linux/sync_file.h>
> > +#include <linux/pci.h>
> >   #include <linux/poll.h>
> >   #include <linux/dma-resv.h>
> >   #include <linux/mm.h>
> > @@ -442,12 +443,16 @@ static long dma_buf_import_sync_file(struct dma_b=
uf *dmabuf,
> >   }
> >   #endif
> >
> > +static long dma_buf_create_pages(struct file *file,
> > +                              struct dma_buf_create_pages_info *create=
_info);
> > +
> >   static long dma_buf_ioctl(struct file *file,
> >                         unsigned int cmd, unsigned long arg)
> >   {
> >       struct dma_buf *dmabuf;
> >       struct dma_buf_sync sync;
> >       enum dma_data_direction direction;
> > +     struct dma_buf_create_pages_info create_info;
> >       int ret;
> >
> >       dmabuf =3D file->private_data;
> > @@ -484,6 +489,12 @@ static long dma_buf_ioctl(struct file *file,
> >       case DMA_BUF_SET_NAME_A:
> >       case DMA_BUF_SET_NAME_B:
> >               return dma_buf_set_name(dmabuf, (const char __user *)arg)=
;
> > +     case DMA_BUF_CREATE_PAGES:
> > +             if (copy_from_user(&create_info, (void __user *)arg,
> > +                                sizeof(create_info)))
> > +                     return -EFAULT;
> > +
> > +             return dma_buf_create_pages(file, &create_info);
> >
> >   #if IS_ENABLED(CONFIG_SYNC_FILE)
> >       case DMA_BUF_IOCTL_EXPORT_SYNC_FILE:
> > @@ -1613,6 +1624,218 @@ void dma_buf_vunmap_unlocked(struct dma_buf *dm=
abuf, struct iosys_map *map)
> >   }
> >   EXPORT_SYMBOL_NS_GPL(dma_buf_vunmap_unlocked, DMA_BUF);
> >
> > +static int dma_buf_pages_release(struct inode *inode, struct file *fil=
e)
> > +{
> > +     struct dma_buf_pages *priv =3D file->private_data;
> > +
> > +     if (priv->type_ops->dma_buf_pages_release)
> > +             priv->type_ops->dma_buf_pages_release(priv, file);
> > +
> > +     percpu_ref_kill(&priv->pgmap.ref);
> > +     /* Drop initial ref after percpu_ref_kill(). */
> > +     percpu_ref_put(&priv->pgmap.ref);
> > +
> > +     return 0;
> > +}
> > +
> > +static void dma_buf_page_free(struct page *page)
> > +{
> > +     struct dma_buf_pages *priv;
> > +     struct dev_pagemap *pgmap;
> > +
> > +     pgmap =3D page->pgmap;
> > +     priv =3D container_of(pgmap, struct dma_buf_pages, pgmap);
> > +
> > +     if (priv->type_ops->dma_buf_page_free)
> > +             priv->type_ops->dma_buf_page_free(priv, page);
> > +}
> > +
> > +const struct dev_pagemap_ops dma_buf_pgmap_ops =3D {
> > +     .page_free      =3D dma_buf_page_free,
> > +};
> > +EXPORT_SYMBOL_GPL(dma_buf_pgmap_ops);
> > +
> > +const struct file_operations dma_buf_pages_fops =3D {
> > +     .release        =3D dma_buf_pages_release,
> > +};
> > +EXPORT_SYMBOL_GPL(dma_buf_pages_fops);
> > +
> > +#ifdef CONFIG_ZONE_DEVICE
> > +static void dma_buf_pages_destroy(struct percpu_ref *ref)
> > +{
> > +     struct dma_buf_pages *priv;
> > +     struct dev_pagemap *pgmap;
> > +
> > +     pgmap =3D container_of(ref, struct dev_pagemap, ref);
> > +     priv =3D container_of(pgmap, struct dma_buf_pages, pgmap);
> > +
> > +     if (priv->type_ops->dma_buf_pages_destroy)
> > +             priv->type_ops->dma_buf_pages_destroy(priv);
> > +
> > +     kvfree(priv->pages);
> > +     kfree(priv);
> > +
> > +     dma_buf_unmap_attachment(priv->attachment, priv->sgt, priv->direc=
tion);
> > +     dma_buf_detach(priv->dmabuf, priv->attachment);
> > +     dma_buf_put(priv->dmabuf);
> > +     pci_dev_put(priv->pci_dev);
> > +}
> > +
> > +static long dma_buf_create_pages(struct file *file,
> > +                              struct dma_buf_create_pages_info *create=
_info)
> > +{
> > +     int err, fd, i, pg_idx;
> > +     struct scatterlist *sg;
> > +     struct dma_buf_pages *priv;
> > +     struct file *new_file;
> > +
> > +     fd =3D get_unused_fd_flags(O_RDWR | O_CLOEXEC);
> > +     if (fd < 0) {
> > +             err =3D fd;
> > +             goto out_err;
> > +     }
> > +
> > +     priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> > +     if (!priv) {
> > +             err =3D -ENOMEM;
> > +             goto out_put_fd;
> > +     }
> > +
> > +     priv->pgmap.type =3D MEMORY_DEVICE_PRIVATE;
> > +     priv->pgmap.ops =3D &dma_buf_pgmap_ops;
> > +     init_completion(&priv->pgmap.done);
> > +
> > +     /* This refcount is incremented every time a page in priv->pages =
is
> > +      * allocated, and decremented every time a page is freed. When
> > +      * it drops to 0, the dma_buf_pages can be destroyed. An initial =
ref is
> > +      * held and the dma_buf_pages is not destroyed until that is drop=
ped.
> > +      */
> > +     err =3D percpu_ref_init(&priv->pgmap.ref, dma_buf_pages_destroy, =
0,
> > +                           GFP_KERNEL);
> > +     if (err)
> > +             goto out_free_priv;
> > +
> > +     /* Initial ref to be dropped after percpu_ref_kill(). */
> > +     percpu_ref_get(&priv->pgmap.ref);
> > +
> > +     priv->pci_dev =3D pci_get_domain_bus_and_slot(
> > +             0, create_info->pci_bdf[0],
> > +             PCI_DEVFN(create_info->pci_bdf[1], create_info->pci_bdf[2=
]));
> > +     if (!priv->pci_dev) {
> > +             err =3D -ENODEV;
> > +             goto out_exit_percpu_ref;
> > +     }
> > +
> > +     priv->dmabuf =3D dma_buf_get(create_info->dma_buf_fd);
> > +     if (IS_ERR(priv->dmabuf)) {
> > +             err =3D PTR_ERR(priv->dmabuf);
> > +             goto out_put_pci_dev;
> > +     }
> > +
> > +     if (priv->dmabuf->size % PAGE_SIZE !=3D 0) {
> > +             err =3D -EINVAL;
> > +             goto out_put_dma_buf;
> > +     }
> > +
> > +     priv->attachment =3D dma_buf_attach(priv->dmabuf, &priv->pci_dev-=
>dev);
> > +     if (IS_ERR(priv->attachment)) {
> > +             err =3D PTR_ERR(priv->attachment);
> > +             goto out_put_dma_buf;
> > +     }
> > +
> > +     priv->num_pages =3D priv->dmabuf->size / PAGE_SIZE;
> > +     priv->pages =3D kvmalloc_array(priv->num_pages, sizeof(struct pag=
e),
> > +                                  GFP_KERNEL);
> > +     if (!priv->pages) {
> > +             err =3D -ENOMEM;
> > +             goto out_detach_dma_buf;
> > +     }
> > +
> > +     for (i =3D 0; i < priv->num_pages; i++) {
> > +             struct page *page =3D &priv->pages[i];
> > +
> > +             mm_zero_struct_page(page);
> > +             set_page_zone(page, ZONE_DEVICE);
> > +             set_page_count(page, 1);
> > +             page->pgmap =3D &priv->pgmap;
> > +     }
> > +
> > +     priv->direction =3D DMA_BIDIRECTIONAL;
> > +     priv->sgt =3D dma_buf_map_attachment(priv->attachment, priv->dire=
ction);
> > +     if (IS_ERR(priv->sgt)) {
> > +             err =3D PTR_ERR(priv->sgt);
> > +             goto out_free_pages;
> > +     }
> > +
> > +     /* write each dma addresses from sgt to each page */
> > +     pg_idx =3D 0;
> > +     for_each_sgtable_dma_sg(priv->sgt, sg, i) {
> > +             size_t len =3D sg_dma_len(sg);
> > +             dma_addr_t dma_addr =3D sg_dma_address(sg);
> > +
> > +             BUG_ON(!PAGE_ALIGNED(len));
> > +             while (len > 0) {
> > +                     priv->pages[pg_idx].zone_device_data =3D (void *)=
dma_addr;
> > +                     pg_idx++;
> > +                     dma_addr +=3D PAGE_SIZE;
> > +                     len -=3D PAGE_SIZE;
> > +             }
> > +     }
> > +
> > +     new_file =3D anon_inode_getfile("[dma_buf_pages]", &dma_buf_pages=
_fops,
> > +                                   (void *)priv, O_RDWR | O_CLOEXEC);
> > +     if (IS_ERR(new_file)) {
> > +             err =3D PTR_ERR(new_file);
> > +             goto out_unmap_dma_buf;
> > +     }
> > +
> > +     priv->type =3D create_info->type;
> > +     priv->create_flags =3D create_info->create_flags;
> > +
> > +     switch (priv->type) {
> > +     default:
> > +             err =3D -EINVAL;
> > +             goto out_put_new_file;
> > +     }
> > +
> > +     if (priv->type_ops->dma_buf_pages_init) {
> > +             err =3D priv->type_ops->dma_buf_pages_init(priv, new_file=
);
> > +             if (err)
> > +                     goto out_put_new_file;
> > +     }
> > +
> > +     fd_install(fd, new_file);
> > +     return fd;
> > +
> > +out_put_new_file:
> > +     fput(new_file);
> > +out_unmap_dma_buf:
> > +     dma_buf_unmap_attachment(priv->attachment, priv->sgt, priv->direc=
tion);
> > +out_free_pages:
> > +     kvfree(priv->pages);
> > +out_detach_dma_buf:
> > +     dma_buf_detach(priv->dmabuf, priv->attachment);
> > +out_put_dma_buf:
> > +     dma_buf_put(priv->dmabuf);
> > +out_put_pci_dev:
> > +     pci_dev_put(priv->pci_dev);
> > +out_exit_percpu_ref:
> > +     percpu_ref_exit(&priv->pgmap.ref);
> > +out_free_priv:
> > +     kfree(priv);
> > +out_put_fd:
> > +     put_unused_fd(fd);
> > +out_err:
> > +     return err;
> > +}
> > +#else
> > +static long dma_buf_create_pages(struct file *file,
> > +                              struct dma_buf_create_pages_info *create=
_info)
> > +{
> > +     return -ENOTSUPP;
> > +}
> > +#endif
> > +
> >   #ifdef CONFIG_DEBUG_FS
> >   static int dma_buf_debug_show(struct seq_file *s, void *unused)
> >   {
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index 3f31baa3293f..5789006180ea 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -540,6 +540,36 @@ struct dma_buf_export_info {
> >       void *priv;
> >   };
> >
> > +struct dma_buf_pages;
> > +
> > +struct dma_buf_pages_type_ops {
> > +     int (*dma_buf_pages_init)(struct dma_buf_pages *priv,
> > +                               struct file *file);
> > +     void (*dma_buf_pages_release)(struct dma_buf_pages *priv,
> > +                                   struct file *file);
> > +     void (*dma_buf_pages_destroy)(struct dma_buf_pages *priv);
> > +     void (*dma_buf_page_free)(struct dma_buf_pages *priv,
> > +                               struct page *page);
> > +};
> > +
> > +struct dma_buf_pages {
> > +     /* fields for dmabuf */
> > +     struct dma_buf *dmabuf;
> > +     struct dma_buf_attachment *attachment;
> > +     struct sg_table *sgt;
> > +     struct pci_dev *pci_dev;
> > +     enum dma_data_direction direction;
> > +
> > +     /* fields for dma-buf pages */
> > +     size_t num_pages;
> > +     struct page *pages;
> > +     struct dev_pagemap pgmap;
> > +
> > +     unsigned int type;
> > +     const struct dma_buf_pages_type_ops *type_ops;
> > +     __u64 create_flags;
> > +};
> > +
> >   /**
> >    * DEFINE_DMA_BUF_EXPORT_INFO - helper macro for exporters
> >    * @name: export-info name
> > @@ -631,4 +661,64 @@ int dma_buf_vmap(struct dma_buf *dmabuf, struct io=
sys_map *map);
> >   void dma_buf_vunmap(struct dma_buf *dmabuf, struct iosys_map *map);
> >   int dma_buf_vmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *m=
ap);
> >   void dma_buf_vunmap_unlocked(struct dma_buf *dmabuf, struct iosys_map=
 *map);
> > +
> > +#ifdef CONFIG_DMA_SHARED_BUFFER
> > +extern const struct file_operations dma_buf_pages_fops;
> > +extern const struct dev_pagemap_ops dma_buf_pgmap_ops;
> > +
> > +static inline bool is_dma_buf_pages_file(struct file *file)
> > +{
> > +     return file->f_op =3D=3D &dma_buf_pages_fops;
> > +}
> > +
> > +static inline bool is_dma_buf_page(struct page *page)
> > +{
> > +     return (is_zone_device_page(page) && page->pgmap &&
> > +             page->pgmap->ops =3D=3D &dma_buf_pgmap_ops);
> > +}
> > +
> > +static inline dma_addr_t dma_buf_page_to_dma_addr(struct page *page)
> > +{
> > +     return (dma_addr_t)page->zone_device_data;
> > +}
> > +
> > +static inline int dma_buf_map_sg(struct device *dev, struct scatterlis=
t *sg,
> > +                              int nents, enum dma_data_direction dir)
> > +{
> > +     struct scatterlist *s;
> > +     int i;
> > +
> > +     for_each_sg(sg, s, nents, i) {
> > +             struct page *pg =3D sg_page(s);
> > +
> > +             s->dma_address =3D dma_buf_page_to_dma_addr(pg);
> > +             sg_dma_len(s) =3D s->length;
> > +     }
> > +
> > +     return nents;
> > +}
> > +#else
> > +static inline bool is_dma_buf_page(struct page *page)
> > +{
> > +     return false;
> > +}
> > +
> > +static inline bool is_dma_buf_pages_file(struct file *file)
> > +{
> > +     return false;
> > +}
> > +
> > +static inline dma_addr_t dma_buf_page_to_dma_addr(struct page *page)
> > +{
> > +     return 0;
> > +}
> > +
> > +static inline int dma_buf_map_sg(struct device *dev, struct scatterlis=
t *sg,
> > +                              int nents, enum dma_data_direction dir)
> > +{
> > +     return 0;
> > +}
> > +#endif
> > +
> > +
> >   #endif /* __DMA_BUF_H__ */
> > diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.=
h
> > index 5a6fda66d9ad..d0f63a2ab7e4 100644
> > --- a/include/uapi/linux/dma-buf.h
> > +++ b/include/uapi/linux/dma-buf.h
> > @@ -179,4 +179,13 @@ struct dma_buf_import_sync_file {
> >   #define DMA_BUF_IOCTL_EXPORT_SYNC_FILE      _IOWR(DMA_BUF_BASE, 2, st=
ruct dma_buf_export_sync_file)
> >   #define DMA_BUF_IOCTL_IMPORT_SYNC_FILE      _IOW(DMA_BUF_BASE, 3, str=
uct dma_buf_import_sync_file)
> >
> > +struct dma_buf_create_pages_info {
> > +     __u8 pci_bdf[3];
> > +     __s32 dma_buf_fd;
> > +     __u32 type;
> > +     __u64 create_flags;
> > +};
> > +
> > +#define DMA_BUF_CREATE_PAGES _IOW(DMA_BUF_BASE, 4, struct dma_buf_crea=
te_pages_info)
> > +
> >   #endif
>


--=20
Thanks,
Mina
