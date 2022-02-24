Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817424C2A17
	for <lists+linux-arch@lfdr.de>; Thu, 24 Feb 2022 12:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiBXLCg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Feb 2022 06:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiBXLCf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Feb 2022 06:02:35 -0500
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Feb 2022 03:02:02 PST
Received: from mailin.vu.nl (mailin.vu.nl [130.37.164.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D0227DF02;
        Thu, 24 Feb 2022 03:02:02 -0800 (PST)
Received: from pexch012b.vu.local (130.37.237.89) by mailin.vu.nl
 (130.37.164.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 11:46:58 +0100
Received: from mail-lf1-f50.google.com (130.37.253.6) by PEXCH012b.vu.local
 (130.37.237.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 11:46:57 +0100
Received: by mail-lf1-f50.google.com with SMTP id f37so3063595lfv.8;
        Thu, 24 Feb 2022 02:46:57 -0800 (PST)
X-Gm-Message-State: AOAM530Fuso+uUcc+mtRZ1lBzeG7jLaEqgLjSNp6rVo1/+2/yO1CnJxA
        FIx/Z40vgpNum0adp2lnzT49KGCxT4+nhIZLITI=
X-Google-Smtp-Source: ABdhPJwe0II6Ep5cCC8xCjrez5s6muy36t2guPMFxsWz+HeYZkkJIqj/Ufst0kRyadwV0TnhvubuGzS2B2WmOkWnHnk=
X-Received: by 2002:ac2:5215:0:b0:443:9d93:392a with SMTP id
 a21-20020ac25215000000b004439d93392amr1387571lfl.269.1645699611491; Thu, 24
 Feb 2022 02:46:51 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <86C4CE7D-6D93-456B-AA82-F8ADEACA40B7@gmail.com>
 <6d191223d93249a98511177d4af08420@pexch012b.vu.local>
In-Reply-To: <6d191223d93249a98511177d4af08420@pexch012b.vu.local>
From:   Cristiano Giuffrida <c.giuffrida@vu.nl>
Date:   Thu, 24 Feb 2022 11:46:40 +0100
X-Gmail-Original-Message-ID: <CANWxqZmDjfhw78ZmbS6H8Y+qurRC7jirm_rgb5WUYJYw7GrEmg@mail.gmail.com>
Message-ID: <CANWxqZmDjfhw78ZmbS6H8Y+qurRC7jirm_rgb5WUYJYw7GrEmg@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jakob <jakobkoschel@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [130.37.253.6]
X-ClientProxiedBy: pexch010b.vu.local (130.37.237.87) To PEXCH012b.vu.local
 (130.37.237.106)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I think the "problem" with this solution is that it doesn't prevent
`tmp` from being used outside the loop still (and people getting it
wrong again)? It would be good to have 'struct gr_request *tmp;' being
visible only inside the loop (i.e., declared in the macro).

On Thu, Feb 24, 2022 at 11:34 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Feb 23, 2022 at 03:16:09PM +0100, Jakob wrote:
> > Note that I changed the location of the struct member 'req' in gr_request
> > to make this work. Instead of reshuffling struct members this can also be
> > introduced by simply adding new struct members in certain spots.
> > In other code locations with the same pattern I didn't have to do that.
> >
> > Assuming '_req' passed to gr_dequeue() is located just past 'ep' on the
> > heap, the check could pass even though the list searched is completely
> > empty.
> >
> > &req->req for the head element will be an out-of-bounds pointer
> > that by coincidence or heap massaging is where '_req' is located.
> >
> > Even if the list is empty the list_for_each_entry() macro will do:
> >
> >       pos = list_first_entry(head, typeof(*pos), member);
> >
> > resolving all the macros (list_first_entry() etc) it will look like this:
> >
> >       pos = container_of(head->next, typeof(*pos), member)
> >
> > Since the list is empty head->next == head and container_of() is called on something
> > that is *not* actually of type gr_request.
> >
> > Next, the check if the end of the loop is hit is evaluated:
> >
> >       !list_entry_is_head(pos, head, member);
> >
> > which will stop the loop directly before executing a single iteration.
> >
> > then using '&req->req' is some bogus pointer pointing just past the struct gr_ep,
> > where in this case '_req' is located.
> >
> > The point I'm trying to make: it's probably not safe to rely on the compiler and
> > that everyone is aware of this risk when adding/removing/reordering struct members.
> >
> >
> > Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> > ---
> > drivers/usb/gadget/udc/gr_udc.c | 25 +++++++++++++++++++++++++
> > drivers/usb/gadget/udc/gr_udc.h |  2 +-
> > 2 files changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
> > index 4b35739d3695..29c662f28428 100644
> > --- a/drivers/usb/gadget/udc/gr_udc.c
> > +++ b/drivers/usb/gadget/udc/gr_udc.c
> > @@ -1718,6 +1718,7 @@ static int gr_dequeue(struct usb_ep *_ep, struct usb_request *_req)
> >               ret = -EINVAL;
> >               goto out;
> >       }
> > +     printk(KERN_INFO "JKL: This does print, but shouldn't");
> >
> >       if (list_first_entry(&ep->queue, struct gr_request, queue) == req) {
> >               /* This request is currently being processed */
> > @@ -1739,6 +1740,30 @@ static int gr_dequeue(struct usb_ep *_ep, struct usb_request *_req)
> >       return ret;
> > }
> >
> > +static int __init init_test_jkl3(void)
> > +{
> > +     struct gr_ep *ep;
> > +     struct gr_udc *dev;
> > +     struct usb_request *_req;
> > +     void *buffer;
> > +
> > +     /* assume the usb_request struct is located just after the 'ep' on the heap */
> > +     buffer = kzalloc(sizeof(struct gr_ep)+sizeof(struct usb_request), GFP_KERNEL);
> > +     ep = buffer;
> > +     _req = buffer+sizeof(struct gr_ep);
> > +
> > +     /* setup to call gr_dequeue() */
> > +     dev = kzalloc(sizeof(struct gr_udc), GFP_KERNEL);
> > +     ep->dev = dev;
> > +     ep->dev->driver = 1;
> > +     INIT_LIST_HEAD(&ep->queue); /* list is empty */
> > +
> > +     gr_dequeue(&ep->ep, _req);
> > +
> > +     return 0;
> > +}
> > +__initcall(init_test_jkl3);
> > +
> > /* Helper for gr_set_halt and gr_set_wedge */
> > static int gr_set_halt_wedge(struct usb_ep *_ep, int halt, int wedge)
> > {
> > diff --git a/drivers/usb/gadget/udc/gr_udc.h b/drivers/usb/gadget/udc/gr_udc.h
> > index 70134239179e..14a18d5b5cf8 100644
> > --- a/drivers/usb/gadget/udc/gr_udc.h
> > +++ b/drivers/usb/gadget/udc/gr_udc.h
> > @@ -159,7 +159,6 @@ struct gr_ep {
> > };
> >
> > struct gr_request {
> > -     struct usb_request req;
> >       struct list_head queue;
> >
> >       /* Chain of dma descriptors */
> > @@ -171,6 +170,7 @@ struct gr_request {
> >       u16 oddlen; /* Size of odd length tail if buffer length is "odd" */
> >
> >       u8 setup; /* Setup packet */
> > +     struct usb_request req;
> > };
> >
> > enum gr_ep0state {
> > --
> > 2.25.1
>
> So, to follow the proposed solution in this thread, the following change
> is the "correct" one to make, right?
>
>
> diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
> index 4b35739d3695..5d65d8ad5281 100644
> --- a/drivers/usb/gadget/udc/gr_udc.c
> +++ b/drivers/usb/gadget/udc/gr_udc.c
> @@ -1690,7 +1690,8 @@ static int gr_queue_ext(struct usb_ep *_ep, struct usb_request *_req,
>  /* Dequeue JUST ONE request */
>  static int gr_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>  {
> -       struct gr_request *req;
> +       struct gr_request *req = NULL;
> +       struct gr_request *tmp;
>         struct gr_ep *ep;
>         struct gr_udc *dev;
>         int ret = 0;
> @@ -1710,11 +1711,13 @@ static int gr_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>         spin_lock_irqsave(&dev->lock, flags);
>
>         /* Make sure it's actually queued on this endpoint */
> -       list_for_each_entry(req, &ep->queue, queue) {
> -               if (&req->req == _req)
> +       list_for_each_entry(tmp, &ep->queue, queue) {
> +               if (&tmp->req == _req) {
> +                       req = tmp;
>                         break;
> +               }
>         }
> -       if (&req->req != _req) {
> +       if (!req) {
>                 ret = -EINVAL;
>                 goto out;
>         }
