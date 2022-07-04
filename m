Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB181564FA1
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 10:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiGDIVh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 04:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiGDIVg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 04:21:36 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4985F53
        for <linux-arch@vger.kernel.org>; Mon,  4 Jul 2022 01:21:30 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id e69so8994210ybh.2
        for <linux-arch@vger.kernel.org>; Mon, 04 Jul 2022 01:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oAjJ2G+6gAo3NoQXMKWlZ5LJd5LqVOnZ6pcF/XS/a/o=;
        b=UXFZDwr6JBwK2q5qPr/COIO9qmmIz9lmrhGw7w7/rzs+kfcHPRyBR1RIINfbYG+wC0
         ne/flXlPkTHYqFJr7xwP+baPm2vcQghjbKQnWmhHZ0Seq8/3bLO3ZtCmE7HyrCD+uXa3
         Ak/IwYZXkTUEMvR4YSvk8ba/Jnedo7sX5W1vwhQmtQ79ea87ru41pUWXS1vpPyIeQqYK
         Zg2+q9IDq2h7C9C0zij4dwI3F48k4KixG8AlVMNy8TDrMHhmvlbeUxvGZfoOL38s+OB7
         AXxHgZI9c53kiB46OCcN3Ptf8FT4Ep7SubW8z9dPvEV0ixRTzOi1JVf6hWlMGt1IvaNV
         fE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oAjJ2G+6gAo3NoQXMKWlZ5LJd5LqVOnZ6pcF/XS/a/o=;
        b=tpuplZ9xAIb/1rwIKpmvjYhzNxe5PG8E5e+6sBvy8V08WTewY8tk9/Wo2zJYIhk+hx
         XBjxUevs9z1gb8HHNev+BlRp7BHHe8nZE1ivJulcrMZZf4rrVHP+2FeS8Xu43cI2BixQ
         aKP0bdDsQ+4zEWSGm/aXibEBwPidZD4KquLEoRmvXEPtY6RlQNIC+f1WcE+8+jBME/Qt
         zIgJMPpBkEITlFudk+PEMRifVsV82t/7TxzeKHIEYrsipr7Jf4GCNkweIwebec2RgRO8
         /FlpcQVdxKpTd0qT5eQHzhUG4vBvUDzqKPyELMsBbwijVyw0rNcy180JD182URcHUYFt
         QEmg==
X-Gm-Message-State: AJIora8FQOALzZMvWnCj3UDN/ZChQdnGXuUpsSQxT9lcy6LVeXnqYsho
        hKptEJfIkx057fY0P5A5z/PiHwcMwRa6oN7E4HcEBg==
X-Google-Smtp-Source: AGRyM1uvvn2NT3D9CeyJTQsZk301rbgl4Ywn/tC/1iro9c2guV8+iimzmBeAuEZ8vF0iGlP3fLAW3ImqodcoEZznQVA=
X-Received: by 2002:a25:6b0b:0:b0:66e:445a:17bb with SMTP id
 g11-20020a256b0b000000b0066e445a17bbmr5396058ybc.147.1656922889083; Mon, 04
 Jul 2022 01:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-44-glider@google.com>
 <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com> <YsJWCREA5xMfmmqx@ZenIV>
In-Reply-To: <YsJWCREA5xMfmmqx@ZenIV>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 4 Jul 2022 10:20:53 +0200
Message-ID: <CAG_fn=V_vDVFNSJTOErNhzk7n=GRjZ_6U6Z=M-Jdmi=ekbS5+g@mail.gmail.com>
Subject: Re: [PATCH v4 43/45] namei: initialize parameters passed to step_into()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Vitaly Buka <vitalybuka@google.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 4, 2022 at 4:53 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Jul 02, 2022 at 10:23:16AM -0700, Linus Torvalds wrote:
>
> > Al - can you please take a quick look?
>
> FWIW, trying to write a coherent documentation had its usual effect...
> The thing is, we don't really need to fetch the inode that early.
> All we really care about is that in RCU mode ->d_seq gets sampled
> before we fetch ->d_inode *and* we don't treat "it looks negative"
> as hard -ENOENT in case of ->d_seq mismatch.
>
> Which can be bloody well left to step_into().  So we don't need
> to pass it inode argument at all - just dentry and seq.  Makes
> a bunch of functions simpler as well...
>
> It does *not* deal with the "uninitialized" seq argument in
> !RCU case; I'll handle that in the followup, but that's a separate
> story, IMO (and very clearly a false positive).

I can confirm that your patch fixes KMSAN reports on inode, yet the
following reports still persist:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
BUG: KMSAN: uninit-value in walk_component+0x5e7/0x6c0 fs/namei.c:1996
 walk_component+0x5e7/0x6c0 fs/namei.c:1996
 lookup_last fs/namei.c:2445
 path_lookupat+0x27d/0x6f0 fs/namei.c:2468
 filename_lookup+0x24c/0x800 fs/namei.c:2497
 kern_path+0x79/0x3a0 fs/namei.c:2587
 init_stat+0x72/0x13f fs/init.c:132
 clean_path+0x74/0x24c init/initramfs.c:339
 do_name+0x12d/0xc17 init/initramfs.c:371
 write_buffer init/initramfs.c:457
 unpack_to_rootfs+0x49a/0xd9e init/initramfs.c:510
 do_populate_rootfs+0x57/0x40f init/initramfs.c:699
 async_run_entry_fn+0x8f/0x400 kernel/async.c:127
 process_one_work+0xb27/0x13e0 kernel/workqueue.c:2289
 worker_thread+0x1076/0x1d60 kernel/workqueue.c:2436
 kthread+0x31b/0x430 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 ??:?

Local variable seq created at:
 walk_component+0x46/0x6c0 fs/namei.c:1981
 lookup_last fs/namei.c:2445
 path_lookupat+0x27d/0x6f0 fs/namei.c:2468

CPU: 0 PID: 10 Comm: kworker/u9:0 Tainted: G    B
5.19.0-rc4-00059-gcf2d25715943-dirty #103
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Workqueue: events_unbound async_run_entry_fn
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

What makes you think they are false positives? Is the scenario I
described above:

"""
In particular, if the call to lookup_fast() in walk_component()
returns NULL, and lookup_slow() returns a valid dentry, then the
`seq` and `inode` will remain uninitialized until the call to
step_into()
"""

impossible?

> Cumulative diff follows; splitup is in #work.namei.  Comments?
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 1f28d3f463c3..7f4f61ade9e3 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1467,7 +1467,7 @@ EXPORT_SYMBOL(follow_down);
>   * we meet a managed dentry that would need blocking.
>   */
>  static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
> -                              struct inode **inode, unsigned *seqp)
> +                              unsigned *seqp)
>  {
>         struct dentry *dentry =3D path->dentry;
>         unsigned int flags =3D dentry->d_flags;
> @@ -1497,13 +1497,6 @@ static bool __follow_mount_rcu(struct nameidata *n=
d, struct path *path,
>                                 dentry =3D path->dentry =3D mounted->mnt.=
mnt_root;
>                                 nd->state |=3D ND_JUMPED;
>                                 *seqp =3D read_seqcount_begin(&dentry->d_=
seq);
> -                               *inode =3D dentry->d_inode;
> -                               /*
> -                                * We don't need to re-check ->d_seq afte=
r this
> -                                * ->d_inode read - there will be an RCU =
delay
> -                                * between mount hash removal and ->mnt_r=
oot
> -                                * becoming unpinned.
> -                                */
>                                 flags =3D dentry->d_flags;
>                                 continue;
>                         }
> @@ -1515,8 +1508,7 @@ static bool __follow_mount_rcu(struct nameidata *nd=
, struct path *path,
>  }
>
>  static inline int handle_mounts(struct nameidata *nd, struct dentry *den=
try,
> -                         struct path *path, struct inode **inode,
> -                         unsigned int *seqp)
> +                         struct path *path, unsigned int *seqp)
>  {
>         bool jumped;
>         int ret;
> @@ -1525,9 +1517,7 @@ static inline int handle_mounts(struct nameidata *n=
d, struct dentry *dentry,
>         path->dentry =3D dentry;
>         if (nd->flags & LOOKUP_RCU) {
>                 unsigned int seq =3D *seqp;
> -               if (unlikely(!*inode))
> -                       return -ENOENT;
> -               if (likely(__follow_mount_rcu(nd, path, inode, seqp)))
> +               if (likely(__follow_mount_rcu(nd, path, seqp)))
>                         return 0;
>                 if (!try_to_unlazy_next(nd, dentry, seq))
>                         return -ECHILD;
> @@ -1547,7 +1537,6 @@ static inline int handle_mounts(struct nameidata *n=
d, struct dentry *dentry,
>                 if (path->mnt !=3D nd->path.mnt)
>                         mntput(path->mnt);
>         } else {
> -               *inode =3D d_backing_inode(path->dentry);
>                 *seqp =3D 0; /* out of RCU mode, so the value doesn't mat=
ter */
>         }
>         return ret;
> @@ -1607,9 +1596,7 @@ static struct dentry *__lookup_hash(const struct qs=
tr *name,
>         return dentry;
>  }
>
> -static struct dentry *lookup_fast(struct nameidata *nd,
> -                                 struct inode **inode,
> -                                 unsigned *seqp)
> +static struct dentry *lookup_fast(struct nameidata *nd, unsigned *seqp)
>  {
>         struct dentry *dentry, *parent =3D nd->path.dentry;
>         int status =3D 1;
> @@ -1628,22 +1615,11 @@ static struct dentry *lookup_fast(struct nameidat=
a *nd,
>                         return NULL;
>                 }
>
> -               /*
> -                * This sequence count validates that the inode matches
> -                * the dentry name information from lookup.
> -                */
> -               *inode =3D d_backing_inode(dentry);
> -               if (unlikely(read_seqcount_retry(&dentry->d_seq, seq)))
> -                       return ERR_PTR(-ECHILD);
> -
> -               /*
> +               /*
>                  * This sequence count validates that the parent had no
>                  * changes while we did the lookup of the dentry above.
> -                *
> -                * The memory barrier in read_seqcount_begin of child is
> -                *  enough, we can use __read_seqcount_retry here.
>                  */
> -               if (unlikely(__read_seqcount_retry(&parent->d_seq, nd->se=
q)))
> +               if (unlikely(read_seqcount_retry(&parent->d_seq, nd->seq)=
))
>                         return ERR_PTR(-ECHILD);
>
>                 *seqp =3D seq;
> @@ -1838,13 +1814,21 @@ static const char *pick_link(struct nameidata *nd=
, struct path *link,
>   * for the common case.
>   */
>  static const char *step_into(struct nameidata *nd, int flags,
> -                    struct dentry *dentry, struct inode *inode, unsigned=
 seq)
> +                    struct dentry *dentry, unsigned seq)
>  {
>         struct path path;
> -       int err =3D handle_mounts(nd, dentry, &path, &inode, &seq);
> +       struct inode *inode;
> +       int err =3D handle_mounts(nd, dentry, &path, &seq);
>
>         if (err < 0)
>                 return ERR_PTR(err);
> +       inode =3D path.dentry->d_inode;
> +       if (unlikely(!inode)) {
> +               if ((nd->flags & LOOKUP_RCU) &&
> +                   read_seqcount_retry(&path.dentry->d_seq, seq))
> +                       return ERR_PTR(-ECHILD);
> +               return ERR_PTR(-ENOENT);
> +       }
>         if (likely(!d_is_symlink(path.dentry)) ||
>            ((flags & WALK_TRAILING) && !(nd->flags & LOOKUP_FOLLOW)) ||
>            (flags & WALK_NOFOLLOW)) {
> @@ -1870,9 +1854,7 @@ static const char *step_into(struct nameidata *nd, =
int flags,
>         return pick_link(nd, &path, inode, seq, flags);
>  }
>
> -static struct dentry *follow_dotdot_rcu(struct nameidata *nd,
> -                                       struct inode **inodep,
> -                                       unsigned *seqp)
> +static struct dentry *follow_dotdot_rcu(struct nameidata *nd, unsigned *=
seqp)
>  {
>         struct dentry *parent, *old;
>
> @@ -1895,7 +1877,6 @@ static struct dentry *follow_dotdot_rcu(struct name=
idata *nd,
>         }
>         old =3D nd->path.dentry;
>         parent =3D old->d_parent;
> -       *inodep =3D parent->d_inode;
>         *seqp =3D read_seqcount_begin(&parent->d_seq);
>         if (unlikely(read_seqcount_retry(&old->d_seq, nd->seq)))
>                 return ERR_PTR(-ECHILD);
> @@ -1910,9 +1891,7 @@ static struct dentry *follow_dotdot_rcu(struct name=
idata *nd,
>         return NULL;
>  }
>
> -static struct dentry *follow_dotdot(struct nameidata *nd,
> -                                struct inode **inodep,
> -                                unsigned *seqp)
> +static struct dentry *follow_dotdot(struct nameidata *nd, unsigned *seqp=
)
>  {
>         struct dentry *parent;
>
> @@ -1937,7 +1916,6 @@ static struct dentry *follow_dotdot(struct nameidat=
a *nd,
>                 return ERR_PTR(-ENOENT);
>         }
>         *seqp =3D 0;
> -       *inodep =3D parent->d_inode;
>         return parent;
>
>  in_root:
> @@ -1952,7 +1930,6 @@ static const char *handle_dots(struct nameidata *nd=
, int type)
>         if (type =3D=3D LAST_DOTDOT) {
>                 const char *error =3D NULL;
>                 struct dentry *parent;
> -               struct inode *inode;
>                 unsigned seq;
>
>                 if (!nd->root.mnt) {
> @@ -1961,17 +1938,17 @@ static const char *handle_dots(struct nameidata *=
nd, int type)
>                                 return error;
>                 }
>                 if (nd->flags & LOOKUP_RCU)
> -                       parent =3D follow_dotdot_rcu(nd, &inode, &seq);
> +                       parent =3D follow_dotdot_rcu(nd, &seq);
>                 else
> -                       parent =3D follow_dotdot(nd, &inode, &seq);
> +                       parent =3D follow_dotdot(nd, &seq);
>                 if (IS_ERR(parent))
>                         return ERR_CAST(parent);
>                 if (unlikely(!parent))
>                         error =3D step_into(nd, WALK_NOFOLLOW,
> -                                        nd->path.dentry, nd->inode, nd->=
seq);
> +                                        nd->path.dentry, nd->seq);
>                 else
>                         error =3D step_into(nd, WALK_NOFOLLOW,
> -                                        parent, inode, seq);
> +                                        parent, seq);
>                 if (unlikely(error))
>                         return error;
>
> @@ -1995,7 +1972,6 @@ static const char *handle_dots(struct nameidata *nd=
, int type)
>  static const char *walk_component(struct nameidata *nd, int flags)
>  {
>         struct dentry *dentry;
> -       struct inode *inode;
>         unsigned seq;
>         /*
>          * "." and ".." are special - ".." especially so because it has
> @@ -2007,7 +1983,7 @@ static const char *walk_component(struct nameidata =
*nd, int flags)
>                         put_link(nd);
>                 return handle_dots(nd, nd->last_type);
>         }
> -       dentry =3D lookup_fast(nd, &inode, &seq);
> +       dentry =3D lookup_fast(nd, &seq);
>         if (IS_ERR(dentry))
>                 return ERR_CAST(dentry);
>         if (unlikely(!dentry)) {
> @@ -2017,7 +1993,7 @@ static const char *walk_component(struct nameidata =
*nd, int flags)
>         }
>         if (!(flags & WALK_MORE) && nd->depth)
>                 put_link(nd);
> -       return step_into(nd, flags, dentry, inode, seq);
> +       return step_into(nd, flags, dentry, seq);
>  }
>
>  /*
> @@ -2473,8 +2449,7 @@ static int handle_lookup_down(struct nameidata *nd)
>  {
>         if (!(nd->flags & LOOKUP_RCU))
>                 dget(nd->path.dentry);
> -       return PTR_ERR(step_into(nd, WALK_NOFOLLOW,
> -                       nd->path.dentry, nd->inode, nd->seq));
> +       return PTR_ERR(step_into(nd, WALK_NOFOLLOW, nd->path.dentry, nd->=
seq));
>  }
>
>  /* Returns 0 and nd will be valid on success; Retuns error, otherwise. *=
/
> @@ -3394,7 +3369,6 @@ static const char *open_last_lookups(struct nameida=
ta *nd,
>         int open_flag =3D op->open_flag;
>         bool got_write =3D false;
>         unsigned seq;
> -       struct inode *inode;
>         struct dentry *dentry;
>         const char *res;
>
> @@ -3410,7 +3384,7 @@ static const char *open_last_lookups(struct nameida=
ta *nd,
>                 if (nd->last.name[nd->last.len])
>                         nd->flags |=3D LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
>                 /* we _can_ be in RCU mode here */
> -               dentry =3D lookup_fast(nd, &inode, &seq);
> +               dentry =3D lookup_fast(nd, &seq);
>                 if (IS_ERR(dentry))
>                         return ERR_CAST(dentry);
>                 if (likely(dentry))
> @@ -3464,7 +3438,7 @@ static const char *open_last_lookups(struct nameida=
ta *nd,
>  finish_lookup:
>         if (nd->depth)
>                 put_link(nd);
> -       res =3D step_into(nd, WALK_TRAILING, dentry, inode, seq);
> +       res =3D step_into(nd, WALK_TRAILING, dentry, seq);
>         if (unlikely(res))
>                 nd->flags &=3D ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);
>         return res;



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherweise
erhalten haben sollten, leiten Sie diese bitte nicht an jemand anderes
weiter, l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie =
mich
bitte wissen, dass die E-Mail an die falsche Person gesendet wurde.


This e-mail is confidential. If you received this communication by
mistake, please don't forward it to anyone else, please erase all
copies and attachments, and please let me know that it has gone to the
wrong person.
