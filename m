Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E18928254B
	for <lists+linux-arch@lfdr.de>; Sat,  3 Oct 2020 18:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgJCQIt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Oct 2020 12:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgJCQIt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Oct 2020 12:08:49 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E98AC0613E7
        for <linux-arch@vger.kernel.org>; Sat,  3 Oct 2020 09:08:49 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id m23so5540012qtq.4
        for <linux-arch@vger.kernel.org>; Sat, 03 Oct 2020 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7dA0GLQmZgF0s82f0JM44RBFZnN/fJiJ12cVDFg89BQ=;
        b=F7V/ExyPH/RD6BiNXS5Zf2Xl2L9x3LlFUhuuLJeUQgqnYyFfNgY71gXku0pYToJVpe
         lfCcmfsnanXbzUrMCAC65ZViHyhOP9KJWULyTsl0xqsvd4l6mi0lYaMz+P0HMyBErwFe
         QpmBj0EEgFQnkpDaTJI31xONDhheFHyZApSkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7dA0GLQmZgF0s82f0JM44RBFZnN/fJiJ12cVDFg89BQ=;
        b=THGOC0mxtCLEZl/aGAqX7Qt/I07LD3jzEhzJmcYGoFVuOPGXgmTuvtV9H0BmjsR1IQ
         cKv1aCkOjZMfDtMkXGCMvQlSwoMC0TNnuOBrN8d8PSrKn+vs9owlwAiljUJsbLm2dgJC
         8aQgvBE68ypM/olfx5enHGrRWJRG6jMraAFpoIDiQ0CdoX+JQaieqct50wf/Ff7v+uCN
         peSIoGsH03+JVlJ078wa6A3erW23ComRXd8IID0hUAQG8rZEUkzYGIf0V0Zi/qvoQ9S+
         rRb4vqYOETbvO33YCi4m9OGLvNDtHD0DL8iGm/yIxV0ETp+wsbReiEJAgdA/tcnIQQ72
         LFKA==
X-Gm-Message-State: AOAM5316SO1n1HFXgwhyS3z+bdIkpINV9uvAHySFDGzW/xzePZokWyxd
        LwpY9Eqwyn5HtdZtaMeLestwXA==
X-Google-Smtp-Source: ABdhPJw1VAU+iInpmErsDZVAi0McTmZ9VW/3FLOWUxWRlo672Dhw7clRFREMQaREEL5mGhbiOMuAJw==
X-Received: by 2002:ac8:44a7:: with SMTP id a7mr7231434qto.173.1601741327333;
        Sat, 03 Oct 2020 09:08:47 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id n11sm3508156qkk.105.2020.10.03.09.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 09:08:46 -0700 (PDT)
Date:   Sat, 3 Oct 2020 12:08:46 -0400
From:   joel@joelfernandes.org
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Litmus test for question from Al Viro
Message-ID: <20201003160846.GA3598977@google.com>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001213048.GF29330@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 01, 2020 at 02:30:48PM -0700, Paul E. McKenney wrote:
> On Thu, Oct 01, 2020 at 12:15:29PM -0400, Alan Stern wrote:
> > On Wed, Sep 30, 2020 at 09:51:16PM -0700, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > Al Viro posted the following query:
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > <viro> fun question regarding barriers, if you have time for that
> > > <viro>         V->A = V->B = 1;
> > > <viro>
> > > <viro> CPU1:
> > > <viro>         to_free = NULL
> > > <viro>         spin_lock(&LOCK)
> > > <viro>         if (!smp_load_acquire(&V->B))
> > > <viro>                 to_free = V
> > > <viro>         V->A = 0
> > > <viro>         spin_unlock(&LOCK)
> > > <viro>         kfree(to_free)
> > > <viro>
> > > <viro> CPU2:
> > > <viro>         to_free = V;
> > > <viro>         if (READ_ONCE(V->A)) {
> > > <viro>                 spin_lock(&LOCK)
> > > <viro>                 if (V->A)
> > > <viro>                         to_free = NULL
> > > <viro>                 smp_store_release(&V->B, 0);
> > > <viro>                 spin_unlock(&LOCK)
> > > <viro>         }
> > > <viro>         kfree(to_free);
> > > <viro> 1) is it guaranteed that V will be freed exactly once and that
> > > 	  no accesses to *V will happen after freeing it?
> > > <viro> 2) do we need smp_store_release() there?  I.e. will anything
> > > 	  break if it's replaced with plain V->B = 0?
> > 
> > Here are my answers to Al's questions:
> > 
> > 1) It is guaranteed that V will be freed exactly once.  It is not 
> > guaranteed that no accesses to *V will occur after it is freed, because 
> > the test contains a data race.  CPU1's plain "V->A = 0" write races with 
> > CPU2's READ_ONCE; if the plain write were replaced with 
> > "WRITE_ONCE(V->A, 0)" then the guarantee would hold.  Equally well, 
> > CPU1's smp_load_acquire could be replaced with a plain read while the 
> > plain write is replaced with smp_store_release.
> > 
> > 2) The smp_store_release in CPU2 is not needed.  Replacing it with a 
> > plain V->B = 0 will not break anything.
> > 
> > Analysis: Apart from the kfree calls themselves, the only access to a 
> > shared variable outside of a critical section is CPU2's READ_ONCE of 
> > V->A.  So let's consider two possibilities:
> > 
> > 1: The READ_ONCE returns 0.  Then CPU2 doesn't execute its critical 
> > section and does kfree(V).  However, the fact that the READ_ONCE got 0 
> > means that CPU1 has already entered its critical section, has already 
> > written to V->A (but with a plain write!) and therefore has already seen 
> > V->B = 1 (because of the smp_load_acquire), and therefore will not free 
> > V.  This case shows that the ordering we require is for CPU1 to read 
> > V->B before it writes V->A.  The ordering can be enforced by using 
> > either a load-acquire (as in the litmus test) or a store-release.
> > 
> > 2: The READ_ONCE returns 1.  Then CPU2 does execute its critical 
> > section, and we can simply treat this case the same as if the critical 
> > section was executed unconditionally.  Whichever CPU runs its critical 
> > section second will free V, and the other CPU won't try to access V 
> > after leaving its own critical section (and thus won't access V after it 
> > has been freed).
> > 
> > > ------------------------------------------------------------------------
> > > 
> > > Of course herd7 supports neither structures nor arrays

FWIW, I turned Al's example into a klitmus test which gave me the freedom to
modify it offline and use structures.

The code of the 2 threads look like this (full module enclosed later in the
email). I don't see any issues with the example above on either x86 or arm64
which I luckily have these days. Al or others could also modify the module
with any variations and test as well:

static void code0(struct v_struct* v,spinlock_t* l,int* out_0_r1) {

        struct v_struct *r1; /* to_free */

        r1 = NULL;
        spin_lock(l);
        if (!smp_load_acquire(&v->b))
                r1 = v;
        v->a = 0;
        spin_unlock(l);

  *out_0_r1 = !!r1;
}

static void code1(struct v_struct* v,spinlock_t* l,int* out_1_r1) {

        struct v_struct *r1; /* to_free */

        r1 = v;
        if (READ_ONCE(v->a)) {
                spin_lock(l);
                if (v->a)
                        r1 = NULL;
                smp_store_release(&v->b, 0);
                spin_unlock(l);
        }

  *out_1_r1 = !!r1;
}

Results on both arm64 and x86:

    Histogram (2 states)
    19080852:>0:r1=1; 1:r1=0;
    20919148:>0:r1=0; 1:r1=1;
    No
    
    Witnesses
    Positive: 0, Negative: 40000000
    Condition exists (0:r1=1 /\ 1:r1=1) is NOT validated
    Hash=4a8c15603ffb5ab464195ea39ccd6382
    Observation AL+test Never 0 40000000
    Time AL+test 6.24

I guess I could do an alloc and free of v_struct. However, I just checked for
whether the to_free in Al's example could ever be NULL for both threads.

Here is the full test. To run it:
modprobe litmus nruns=200
cat /proc/litmus
rmmod

(The file_operations may need to be replaced trivially with proc_operations
for >5.4 kernels)

---8<-----------------------

diff --git a/Makefile b/Makefile
index 57ef8d1d5c24..493b7583f111 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 VERSION = 5
 PATCHLEVEL = 4
 SUBLEVEL = 68
-EXTRAVERSION =
+EXTRAVERSION = litmus
 NAME = Kleptomaniac Octopus
 
 # *DOCUMENTATION*
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 9a3dda3a9d06..5af1bc2ab9a1 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -3,6 +3,7 @@
 # Makefile for misc devices that really don't fit anywhere else.
 #
 
+obj-m                           += mymodules/
 obj-$(CONFIG_IBM_ASM)		+= ibmasm/
 obj-$(CONFIG_IBMVMC)		+= ibmvmc.o
 obj-$(CONFIG_AD525X_DPOT)	+= ad525x_dpot.o
diff --git a/drivers/misc/mymodules/Makefile b/drivers/misc/mymodules/Makefile
new file mode 100644
index 000000000000..1ebb67fbc9ba
--- /dev/null
+++ b/drivers/misc/mymodules/Makefile
@@ -0,0 +1,8 @@
+ccflags-y += -std=gnu99 -Wno-declaration-after-statement
+obj-m += litmus000.o
+
+all:
+	make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) modules
+
+clean:
+	make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) clean
diff --git a/drivers/misc/mymodules/README.txt b/drivers/misc/mymodules/README.txt
new file mode 100644
index 000000000000..2af0ca89349f
--- /dev/null
+++ b/drivers/misc/mymodules/README.txt
@@ -0,0 +1,25 @@
+Kernel modules produced by klitmus7
+
+REQUIREMEMTS
+  - kernel headers for compiling modules.
+  - commands insmod and rmmod for installing and removing kernel modules.
+
+COMPILING
+  Once kernel headers are installed, just type 'make'
+
+RUNNING
+  Run script 'run.sh' as root, e.g. as 'sudo sh run.sh'
+  Some parameters can be passed to the script by adding
+  key=value command line arguments.
+  Main arguments are as follows:
+    * size=<n>   Tests operate on arrays of size <n>.
+    * nruns=<n>  And are repeated <n> times.
+    * stride=<n> Arrays are scanned with stride <n>.
+    * avail=<n>  Number of cores are devoted to tests.
+
+  If <avail> is the special value zero or exceeds <a>, the number of actually online cores,
+  then tests will occupy <a> cores.
+
+  By default the script runs as if called as:
+    sudo sh run.sh size=100000 nruns=10 stride=1 avail=0
+
diff --git a/drivers/misc/mymodules/litmus000.c b/drivers/misc/mymodules/litmus000.c
new file mode 100644
index 000000000000..7702e22c7126
--- /dev/null
+++ b/drivers/misc/mymodules/litmus000.c
@@ -0,0 +1,576 @@
+/****************************************************************************/
+/*                           the diy toolsuite                              */
+/*                                                                          */
+/* Jade Alglave, University College London, UK.                             */
+/* Luc Maranget, INRIA Paris-Rocquencourt, France.                          */
+/*                                                                          */
+/* This C source is a product of litmus7 and includes source that is        */
+/* governed by the CeCILL-B license.                                        */
+/****************************************************************************/
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/kthread.h>
+#include <linux/ktime.h>
+#include <linux/atomic.h>
+#include <linux/sysfs.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/slab.h>
+#include <linux/random.h>
+
+typedef u64 count_t;
+#define PCTR "llu"
+
+#ifndef WRITE_ONCE
+#define WRITE_ONCE(x,v) ({ ACCESS_ONCE((x)) = (v); })
+#endif
+#ifndef READ_ONCE
+#define READ_ONCE(x) ACCESS_ONCE((x))
+#endif
+
+#ifndef smp_store_release
+#define smp_store_release(p, v)                                         \
+do {                                                                    \
+        smp_mb();                                                       \
+        WRITE_ONCE(*p, v);                                              \
+} while (0)
+#endif
+
+#ifndef smp_load_acquire
+#define smp_load_acquire(p)                                             \
+({                                                                      \
+        typeof(*p) ___p1 = READ_ONCE(*p);                               \
+        smp_mb();                                                       \
+        ___p1;                                                          \
+})
+#endif
+
+#ifndef xchg_acquire
+#define xchg_acquire(x,v) xchg(x,v)
+#endif
+
+#ifndef xchg_release
+#define xchg_release(x,v) xchg(x,v)
+#endif
+
+#ifndef lockless_dereference 
+#define lockless_dereference(p)                                         \
+({                                                                      \
+        typeof(p) ____p1 = READ_ONCE(p);                                \
+        smp_read_barrier_depends();                                     \
+        ____p1;                                                         \
+})
+#endif
+
+#ifndef cond_resched_rcu_qs
+#define cond_resched_rcu_qs cpu_relax
+#endif
+
+/* Some constant divide (not available on ARMv7) */
+
+inline static u64 divBy10(u64 n) {
+ u64 q, r;
+ q = (n >> 1) + (n >> 2);
+ q = q + (q >> 4);
+ q = q + (q >> 8);
+ q = q + (q >> 16);
+ q = q >> 3;
+ r = n - q*10;
+ return q + ((r + 6) >> 4);
+}
+
+inline static u64 divBy1000(u64 n) {
+  u64 q, r, t;
+  t = (n >> 7) + (n >> 8) + (n >> 12);
+  q = (n >> 1) + t + (n >> 15) + (t >> 11) + (t >> 14);
+  q = q >> 9;
+  r = n - q*1000;
+  return q + ((r + 24) >> 10);
+}
+
+static int randmod(unsigned int m) {
+  unsigned int x ;
+  get_random_bytes(&x,sizeof(x));
+  return x % m ;
+}
+
+static void shuffle_array(int *t,int sz) {
+  for  (int k = 0 ; k < sz-1; k++) {
+    int j = k + randmod(sz-k);
+    int tmp = t[k] ;
+    t[k] = t[j];
+    t[j] = tmp;
+  }
+}
+/**************/
+/* Parameters */
+/**************/
+
+static const int nthreads = 2;
+static unsigned int nruns = 10;
+static unsigned int size = 100000;
+static unsigned int stride = 1;
+static unsigned int avail = 0;
+static unsigned int ninst = 0;
+static int affincr = 0;
+
+module_param(nruns,uint,0644);
+module_param(size,uint,0644);
+module_param(stride,uint,0644);
+module_param(avail,uint,0644);
+module_param(ninst,uint,0644);
+module_param(affincr,int,0644);
+
+static char *name = "AL+test";
+module_param(name,charp,0444);
+
+static wait_queue_head_t *wq;
+static atomic_t done = ATOMIC_INIT(0);
+
+/************/
+/* Outcomes */
+/************/
+
+#define NOUTS 2
+typedef u64 outcome_t[NOUTS];
+
+static const int out_0_r1_f = 0 ;
+static const int out_1_r1_f = 1 ;
+
+typedef struct outs_t {
+  struct outs_t *next,*down ;
+  count_t c ;
+  u64 k ;
+  int show ;
+} outs_t ;
+
+
+static outs_t *alloc_outs(u64 k) {
+  outs_t *r = kmalloc(sizeof(*r),GFP_KERNEL) ;
+  if (r == NULL) return NULL ;
+  r->k = k ;
+  r->c = 0 ;
+  r->show = 0 ;
+  r->next = r->down = NULL ;
+  return r ;
+}
+
+static void free_outs(outs_t *p) {
+  if (p == NULL) return ;
+  free_outs(p->next) ;
+  free_outs(p->down) ;
+  kfree(p) ;
+}
+
+static outs_t *
+loop_add_outcome_outs(outs_t *p, u64 *k, int i, count_t c, int show) {
+  outs_t *r = p ;
+  if (p == NULL || k[i] < p->k) {
+    r = alloc_outs(k[i]) ;
+    if (r == NULL) return p ; /* simply ignore insert */
+    r->next = p ;
+    p = r ;
+  }
+  for ( ; ; ) {
+    outs_t **q ;
+    if (k[i] > p->k) {
+      q = &(p->next) ;
+      p = p->next ;
+    } else if (i <= 0) {
+      p->c += c ;
+      p->show = show || p->show ;
+      return r ;
+    } else {
+      i-- ;
+      q = &(p->down) ;
+      p = p->down ;
+    }
+    if (p == NULL || k[i] < p->k) {
+      outs_t *a = alloc_outs(k[i]) ;
+      if (a == NULL) return r ;
+      a->next = p ;
+      p = a ;
+      *q = a ;
+    }
+  }
+}
+
+typedef count_t cfun(outs_t *) ;
+
+static count_t count_scan(cfun *f,outs_t *p) {
+  count_t r = 0 ;
+  for ( ; p ; p = p->next) {
+    r += f(p) ;
+    if (p->down) {
+      r += count_scan(f,p->down) ;
+    }
+  }
+  return r ;
+} 
+
+static count_t cshow(outs_t *p) {
+  if (p->show) return p->c ;
+  return 0 ;
+}
+
+static count_t count_show(outs_t *p) { return count_scan(cshow,p) ; }
+
+static count_t cnoshow(outs_t *p) {
+  if (!p->show) return p->c ;
+  return 0 ;
+}
+
+static count_t count_noshow(outs_t *p) { return count_scan(cnoshow,p); }
+
+static count_t cnstates(outs_t *p) {
+  if (p->c > 0) return 1 ;
+  return 0 ;
+}
+
+static count_t count_nstates(outs_t *p) { return count_scan(cnstates,p); }
+
+
+static outs_t *add_outcome_outs(outs_t *p,u64 *k,int show) {
+  return loop_add_outcome_outs(p,k,NOUTS-1,1,show);
+}
+
+static void do_dump_outs (struct seq_file *m,outs_t *p,u64 *o,int sz) {
+  for ( ; p ; p = p->next) {
+    o[sz-1] = p->k;
+    if (p->c > 0) {
+      seq_printf(m,"%-8"PCTR"%c>0:r1=%i; 1:r1=%i;\n",p->c,p->show ? '*' : ':',(int)o[out_0_r1_f],(int)o[out_1_r1_f]);
+    } else {
+      do_dump_outs(m,p->down,o,sz-1);
+    }
+  }
+}
+
+static void dump_outs(struct seq_file *m,outs_t *p) {
+  outcome_t buff;
+  do_dump_outs(m,p,buff,NOUTS);
+}
+
+static inline void barrier_wait(int id,int i,int *b) {
+  if ((i % nthreads) == id) {
+    WRITE_ONCE(*b,1);
+    smp_mb();
+  } else {
+    int _spin = 256;
+    for  ( ; ; ) {
+      if (READ_ONCE(*b) != 0) return;
+      if (--_spin <= 0) return;
+      cpu_relax();
+    }
+  }
+}
+
+
+/****************/
+/* Affinity     */
+/****************/
+
+static int *online;
+static int nonline;
+
+/****************/
+/* Test Context */
+/****************/
+
+struct v_struct {
+  int a;
+  int b;
+};
+
+typedef struct {
+/* Shared locations */
+  struct v_struct *v;
+  spinlock_t *l;
+/* Final contents of observed registers */
+  int *out_0_r1;
+  int *out_1_r1;
+/* For synchronisation */
+  int *barrier;
+} ctx_t ;
+
+static ctx_t **ctx;
+
+static void free_ctx(ctx_t *p) { 
+  if (p == NULL) return;
+  if (p->v) kfree(p->v);
+  if (p->l) kfree(p->l);
+  if (p->out_0_r1) kfree(p->out_0_r1);
+  if (p->out_1_r1) kfree(p->out_1_r1);
+  if (p->barrier) kfree(p->barrier);
+  kfree(p);
+}
+
+static ctx_t *alloc_ctx(size_t sz) { 
+  ctx_t *r = kzalloc(sizeof(*r),GFP_KERNEL);
+  if (!r) { return NULL; }
+  r->v = kmalloc(sizeof(r->v[0])*sz,GFP_KERNEL);
+  if (!r->v) { return NULL; }
+  r->l = kmalloc(sizeof(r->l[0])*sz,GFP_KERNEL);
+  if (!r->l) { return NULL; }
+  for (int _i=0 ; _i < sz ; _i++) spin_lock_init(&r->l[_i]);
+  r->out_0_r1 = kmalloc(sizeof(r->out_0_r1[0])*sz,GFP_KERNEL);
+  if (!r->out_0_r1) { return NULL; }
+  r->out_1_r1 = kmalloc(sizeof(r->out_1_r1[0])*sz,GFP_KERNEL);
+  if (!r->out_1_r1) { return NULL; }
+  r->barrier = kmalloc(sizeof(r->barrier[0])*sz,GFP_KERNEL);
+  if (!r->barrier) { return NULL; }
+  return r;
+}
+
+static void init_ctx(ctx_t *_a,size_t sz) {
+  for (int _i = 0 ; _i < sz ; _i++) {
+    _a->v[_i].a = 1;
+    _a->v[_i].b = 1;
+    _a->out_0_r1[_i] = -239487;
+    _a->out_1_r1[_i] = -239487;
+    _a->barrier[_i] = 0;
+  }
+}
+
+/***************/
+/* Litmus code */
+/***************/
+
+static void code0(struct v_struct* v,spinlock_t* l,int* out_0_r1) {
+
+	struct v_struct *r1; /* to_free */
+
+	r1 = NULL;
+	spin_lock(l);
+	if (!smp_load_acquire(&v->b))
+		r1 = v;
+	v->a = 0;
+	spin_unlock(l);
+
+  *out_0_r1 = !!r1;
+}
+
+static int thread0(void *_p) {
+  ctx_t *_a = (ctx_t *)_p;
+
+  smp_mb();
+  for (int _j = 0 ; _j < stride ; _j++) {
+    for (int _i = _j ; _i < size ; _i += stride) {
+      barrier_wait(0,_i,&_a->barrier[_i]);
+      code0(&_a->v[_i],&_a->l[_i],&_a->out_0_r1[_i]);
+    }
+  }
+  atomic_inc(&done);
+  smp_mb();
+  wake_up(wq);
+  smp_mb();
+  do_exit(0);
+}
+
+static void code1(struct v_struct* v,spinlock_t* l,int* out_1_r1) {
+
+	struct v_struct *r1; /* to_free */
+
+	r1 = v;
+	if (READ_ONCE(v->a)) {
+		spin_lock(l);
+		if (v->a)
+			r1 = NULL;
+                smp_store_release(&v->b, 0);
+		spin_unlock(l);
+	}
+
+  *out_1_r1 = !!r1;
+}
+
+static int thread1(void *_p) {
+  ctx_t *_a = (ctx_t *)_p;
+
+  smp_mb();
+  for (int _j = 0 ; _j < stride ; _j++) {
+    for (int _i = _j ; _i < size ; _i += stride) {
+      barrier_wait(1,_i,&_a->barrier[_i]);
+      code1(&_a->v[_i],&_a->l[_i],&_a->out_1_r1[_i]);
+    }
+  }
+  atomic_inc(&done);
+  smp_mb();
+  wake_up(wq);
+  smp_mb();
+  do_exit(0);
+}
+
+inline static int final_cond(int _out_0_r1,int _out_1_r1) {
+  switch (_out_0_r1) {
+  case 1:
+    switch (_out_1_r1) {
+    case 1:
+      return 1;
+    default:
+      return 0;
+    }
+  default:
+    return 0;
+  }
+}
+
+/********/
+/* Zyva */
+/********/
+
+static outs_t *zyva(void) {
+  ctx_t **c = ctx;
+  outs_t *outs = NULL;
+  const int nth = ninst * nthreads;
+  struct task_struct **th;
+
+  th = kzalloc(sizeof(struct task_struct *) * nth, GFP_KERNEL);
+  if (!th) return NULL;
+  for (int _k = 0 ; _k < nruns ; _k++) {
+    int _nth = 0;
+
+    for (int _ni = 0 ; _ni < ninst ; _ni++) init_ctx(c[_ni],size);
+    atomic_set(&done,0);
+    smp_mb();
+    for (int _ni = 0 ; _ni < ninst ; _ni++) {
+      th[_nth] = kthread_create(thread0,c[_ni],"thread0");
+      if (IS_ERR(th[_nth])) {kfree(th); return outs;}
+      _nth++;
+      th[_nth] = kthread_create(thread1,c[_ni],"thread1");
+      if (IS_ERR(th[_nth])) {kfree(th); return outs;}
+      _nth++;
+    }
+    if (affincr != 0) {
+      int _idx=0, _idx0=0, _incr=affincr > 0 ? affincr : 1;
+      if (affincr < 0) shuffle_array(online,nonline);
+      for (int _t = 0 ; _t < nth ; _t++) {
+        kthread_bind(th[_t],online[_idx]);
+        _idx += _incr; 
+        if (_idx >= nonline) _idx = ++_idx0;
+        if (_idx >= nonline) _idx = _idx0 = 0;
+      }
+    }
+    for (int _t = 0 ; _t < nth ; _t++) wake_up_process(th[_t]);
+    wait_event_interruptible(*wq, atomic_read(&done) == nth);
+    smp_mb();
+    for (int _ni = 0 ; _ni < ninst ; _ni++) {
+      ctx_t *_a = c[_ni];
+      for (int _i = 0 ; _i < size ; _i++) {
+        outcome_t _o;
+        int _cond;
+        _cond = final_cond(_a->out_0_r1[_i],_a->out_1_r1[_i]);
+        _o[out_0_r1_f] = _a->out_0_r1[_i];
+        _o[out_1_r1_f] = _a->out_1_r1[_i];
+        outs = add_outcome_outs(outs,_o,_cond);
+      }
+    }
+    cond_resched();
+  }
+  kfree(th);
+  return outs;
+}
+
+static int do_it(struct seq_file *m) {
+  ktime_t time_start = ktime_get();
+  outs_t *outs = zyva();
+  ktime_t time_end = ktime_get();
+  seq_printf(m,"Test AL+test Allowed\n");
+  seq_printf(m,"Histogram (%"PCTR" states)\n",count_nstates(outs));
+  dump_outs(m,outs);
+  {
+    count_t pos=count_show(outs),neg=count_noshow(outs);
+    char *msg = "Sometimes";
+    u64 delta =  ktime_to_ms(ktime_sub(time_end, time_start));
+    u64 sec = divBy1000(delta);
+    u64 cent = divBy10(delta-1000*sec + 5);
+    seq_printf(m,"%s\n\n",pos > 0 ? "Ok" : "No");
+    seq_printf(m,"Witnesses\nPositive: %"PCTR", Negative: %"PCTR"\n",pos,neg);
+    seq_printf(m,"Condition exists (0:r1=1 /\\ 1:r1=1) is %svalidated\n",pos > 0?"":"NOT ");
+    seq_printf(m,"%s\n","Hash=4a8c15603ffb5ab464195ea39ccd6382");
+    if (pos == 0) msg = "Never";
+    else if (neg == 0) msg = "Always";
+    seq_printf(m,"Observation AL+test %s %"PCTR" %"PCTR"\n",msg,pos,neg);
+    seq_printf(m,"Time AL+test %llu.%02llu\n\n",sec,cent);
+  }
+  free_outs(outs);
+  return 0;
+}
+
+static int
+litmus_proc_show(struct seq_file *m,void *v) {
+  if (ninst == 0 || ninst * nthreads > nonline) {
+    seq_printf(m,"%s: skipped\n","AL+test");
+    return 0;
+  } else {
+  return do_it(m);
+  }
+}
+
+static int
+litmus_proc_open(struct inode *inode,struct file *fp) {
+  return single_open(fp,litmus_proc_show,NULL);
+}
+
+static const struct file_operations litmus_proc_fops = {
+  .owner   = THIS_MODULE,
+  .open    = litmus_proc_open,
+  .read    = seq_read,
+  .llseek   = seq_lseek,
+  .release = single_release,
+};
+
+static int __init
+litmus_init(void) {
+  int err=0;
+  struct proc_dir_entry *litmus_pde = proc_create("litmus",0,NULL,&litmus_proc_fops);
+  if (litmus_pde == NULL) { return -ENOMEM; }
+  stride = stride == 0 ? 1 : stride;
+  nonline = num_online_cpus ();
+  online = kzalloc(sizeof(*online)*nonline,GFP_KERNEL);
+  if (online == NULL) goto clean_pde;
+  {
+    int cpu,_k;
+    _k=0; for_each_cpu(cpu,cpu_online_mask) online[_k++] = cpu;
+  }
+  if (avail == 0 || avail > nonline) avail = nonline;
+  if (ninst == 0) ninst = avail / nthreads ;
+
+  ctx = kzalloc(sizeof(ctx[0])*ninst,GFP_KERNEL);
+  if (ctx == NULL) { err = -ENOMEM ; goto clean_online; }
+  for (int _k=0 ; _k < ninst ; _k++) {
+    ctx[_k] = alloc_ctx(size);
+    if (ctx[_k] == NULL) { err = -ENOMEM; goto clean_ctx; }
+  }
+
+  wq =  kzalloc(sizeof(*wq), GFP_KERNEL);
+  if (wq == NULL) { err = -ENOMEM; goto clean_ctx; }
+  init_waitqueue_head(wq);
+  return 0; 
+clean_ctx:
+  for (int k=0 ; k < ninst ; k++) free_ctx(ctx[k]);
+  kfree(ctx);
+clean_online:
+  kfree(online);
+clean_pde:
+  remove_proc_entry("litmus",NULL);
+  return err;
+}
+
+static void __exit
+litmus_exit(void) {
+  for (int k=0 ; k < ninst ; k++) free_ctx(ctx[k]);
+  kfree(ctx);
+  kfree(online);
+  remove_proc_entry("litmus",NULL);
+}
+
+module_init(litmus_init);
+module_exit(litmus_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Luc");
+MODULE_DESCRIPTION("Litmus module");
diff --git a/drivers/misc/mymodules/run.sh b/drivers/misc/mymodules/run.sh
new file mode 100644
index 000000000000..c373bfc285db
--- /dev/null
+++ b/drivers/misc/mymodules/run.sh
@@ -0,0 +1,20 @@
+OPT="$*"
+date
+echo Compilation command: "/usr/local/google/home/joelaf/.local/bin/klitmus7 -o mymodules/ viro.litmus"
+echo "OPT=$OPT"
+echo "uname -r=$(uname -r)"
+echo
+
+zyva () {
+  name=$1
+  ko=$2
+  if test -f  $ko
+  then
+    insmod $ko $OPT
+    cat /proc/litmus
+    rmmod $ko
+  fi
+}
+
+zyva "AL+test" litmus000.ko
+date
-- 
2.28.0.806.g8561365e88-goog

