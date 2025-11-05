Return-Path: <linux-arch+bounces-14523-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74CAC3732A
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 18:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6936C665EF5
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 17:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3BA34214C;
	Wed,  5 Nov 2025 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJzAi+et"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C2B341656;
	Wed,  5 Nov 2025 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363368; cv=none; b=NE3e4ysPfqcGgdgGTeGpJWZeDPq4BpPnTU9+AMSyZgTLo8s+BrjrzdsxDz08zlo9PKDAdz1LH8GWjrzupW5aBWGPCNIUIipowMEFHaIFjBsPqT9HXcdeX27Y3sdEzHCmftzJ+9Zg9vt6POJsDnFtEHP26g5NJ+hy59C1JcZHRO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363368; c=relaxed/simple;
	bh=4gfOWwW0GFfhp9pQAKvKIhPMiQyCt9baT5qwGYjaEoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIzb7RGZQLjtxxcD4c+jdUu+qZ5mrFUJuPIiqt8qLrh2OoMGbG5LSh8OW4VxOg4ckQm59OYAHvPK0avZWGo+vvvfH2gk8O3l2JEmjKE9tge5UrCSbFnYUSICpnJCZyXd0SoKcACoWGVBR6MHmr7YtY8eq3+06/cflRPHFs9rtqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJzAi+et; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762363366; x=1793899366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4gfOWwW0GFfhp9pQAKvKIhPMiQyCt9baT5qwGYjaEoU=;
  b=RJzAi+etWLsi25WoUVov9tGmfwitKXK0me6TMxp+4MKkZIANthiip0L8
   1nNp7Ht0fojlYaRSE07D+K7vqSgZLlI6Fh/DPq68qLO1RVqn+lX1VbzC+
   xnspjVKVk2LBPqNGi36Wi11Ty2v0VoODxhTgG+jVcDwdPl3M8gihcpsTs
   JAw1mYJi6J9Ye0gPva8y8MYVv2o3r2HkMU1YIWVhsJten0NqtuMk+h9/Y
   MRwKidlV8eu7L9+iVGR5V5RmX6LD6OhSAGKBJRYHbHrj5TtTOVuyJFqrc
   /a0vDwBCwjJMMZ9xiSeQYxH1jwQUNp6NmeNoXQhY5dfZ1j241a42DlKsS
   Q==;
X-CSE-ConnectionGUID: SrBx/XnRR6ymVmxBb0tFgg==
X-CSE-MsgGUID: N5uB3qrfRWiXHmlRzKxSwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="68138873"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="68138873"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 09:22:45 -0800
X-CSE-ConnectionGUID: TKbHJc1sSSK5BwuR0hqAkQ==
X-CSE-MsgGUID: ethfkIvNQum9yX43XwuImw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="192686787"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 05 Nov 2025 09:22:36 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGhCC-000SvP-2a;
	Wed, 05 Nov 2025 17:21:38 +0000
Date: Thu, 6 Nov 2025 01:16:38 +0800
From: kernel test robot <lkp@intel.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mina Almasry <almasrymina@google.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 4/6] net: devmem: add SO_DEVMEM_AUTORELEASE
 for autorelease control
Message-ID: <202511060041.0DVnS1CV-lkp@intel.com>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-4-ea98cf4d40b3@meta.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-4-ea98cf4d40b3@meta.com>

Hi Bobby,

kernel test robot noticed the following build errors:

[auto build test ERROR on 255d75ef029f33f75fcf5015052b7302486f7ad2]

url:    https://github.com/intel-lab-lkp/linux/commits/Bobby-Eshleman/net-devmem-rename-tx_vec-to-vec-in-dmabuf-binding/20251105-092703
base:   255d75ef029f33f75fcf5015052b7302486f7ad2
patch link:    https://lore.kernel.org/r/20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-4-ea98cf4d40b3%40meta.com
patch subject: [PATCH net-next v6 4/6] net: devmem: add SO_DEVMEM_AUTORELEASE for autorelease control
config: sparc64-randconfig-002-20251105 (https://download.01.org/0day-ci/archive/20251106/202511060041.0DVnS1CV-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251106/202511060041.0DVnS1CV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511060041.0DVnS1CV-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/sock.c: In function 'sk_setsockopt':
>> net/core/sock.c:1395:7: error: 'SO_DEVMEM_AUTORELEASE' undeclared (first use in this function)
    1395 |  case SO_DEVMEM_AUTORELEASE:
         |       ^~~~~~~~~~~~~~~~~~~~~
   net/core/sock.c:1395:7: note: each undeclared identifier is reported only once for each function it appears in
   net/core/sock.c: In function 'sk_getsockopt':
   net/core/sock.c:2255:7: error: 'SO_DEVMEM_AUTORELEASE' undeclared (first use in this function)
    2255 |  case SO_DEVMEM_AUTORELEASE:
         |       ^~~~~~~~~~~~~~~~~~~~~


vim +/SO_DEVMEM_AUTORELEASE +1395 net/core/sock.c

  1282	
  1283	/*
  1284	 *	This is meant for all protocols to use and covers goings on
  1285	 *	at the socket level. Everything here is generic.
  1286	 */
  1287	
  1288	int sk_setsockopt(struct sock *sk, int level, int optname,
  1289			  sockptr_t optval, unsigned int optlen)
  1290	{
  1291		struct so_timestamping timestamping;
  1292		struct socket *sock = sk->sk_socket;
  1293		struct sock_txtime sk_txtime;
  1294		int val;
  1295		int valbool;
  1296		struct linger ling;
  1297		int ret = 0;
  1298	
  1299		/*
  1300		 *	Options without arguments
  1301		 */
  1302	
  1303		if (optname == SO_BINDTODEVICE)
  1304			return sock_setbindtodevice(sk, optval, optlen);
  1305	
  1306		if (optlen < sizeof(int))
  1307			return -EINVAL;
  1308	
  1309		if (copy_from_sockptr(&val, optval, sizeof(val)))
  1310			return -EFAULT;
  1311	
  1312		valbool = val ? 1 : 0;
  1313	
  1314		/* handle options which do not require locking the socket. */
  1315		switch (optname) {
  1316		case SO_PRIORITY:
  1317			if (sk_set_prio_allowed(sk, val)) {
  1318				sock_set_priority(sk, val);
  1319				return 0;
  1320			}
  1321			return -EPERM;
  1322		case SO_TYPE:
  1323		case SO_PROTOCOL:
  1324		case SO_DOMAIN:
  1325		case SO_ERROR:
  1326			return -ENOPROTOOPT;
  1327	#ifdef CONFIG_NET_RX_BUSY_POLL
  1328		case SO_BUSY_POLL:
  1329			if (val < 0)
  1330				return -EINVAL;
  1331			WRITE_ONCE(sk->sk_ll_usec, val);
  1332			return 0;
  1333		case SO_PREFER_BUSY_POLL:
  1334			if (valbool && !sockopt_capable(CAP_NET_ADMIN))
  1335				return -EPERM;
  1336			WRITE_ONCE(sk->sk_prefer_busy_poll, valbool);
  1337			return 0;
  1338		case SO_BUSY_POLL_BUDGET:
  1339			if (val > READ_ONCE(sk->sk_busy_poll_budget) &&
  1340			    !sockopt_capable(CAP_NET_ADMIN))
  1341				return -EPERM;
  1342			if (val < 0 || val > U16_MAX)
  1343				return -EINVAL;
  1344			WRITE_ONCE(sk->sk_busy_poll_budget, val);
  1345			return 0;
  1346	#endif
  1347		case SO_MAX_PACING_RATE:
  1348			{
  1349			unsigned long ulval = (val == ~0U) ? ~0UL : (unsigned int)val;
  1350			unsigned long pacing_rate;
  1351	
  1352			if (sizeof(ulval) != sizeof(val) &&
  1353			    optlen >= sizeof(ulval) &&
  1354			    copy_from_sockptr(&ulval, optval, sizeof(ulval))) {
  1355				return -EFAULT;
  1356			}
  1357			if (ulval != ~0UL)
  1358				cmpxchg(&sk->sk_pacing_status,
  1359					SK_PACING_NONE,
  1360					SK_PACING_NEEDED);
  1361			/* Pairs with READ_ONCE() from sk_getsockopt() */
  1362			WRITE_ONCE(sk->sk_max_pacing_rate, ulval);
  1363			pacing_rate = READ_ONCE(sk->sk_pacing_rate);
  1364			if (ulval < pacing_rate)
  1365				WRITE_ONCE(sk->sk_pacing_rate, ulval);
  1366			return 0;
  1367			}
  1368		case SO_TXREHASH:
  1369			if (!sk_is_tcp(sk))
  1370				return -EOPNOTSUPP;
  1371			if (val < -1 || val > 1)
  1372				return -EINVAL;
  1373			if ((u8)val == SOCK_TXREHASH_DEFAULT)
  1374				val = READ_ONCE(sock_net(sk)->core.sysctl_txrehash);
  1375			/* Paired with READ_ONCE() in tcp_rtx_synack()
  1376			 * and sk_getsockopt().
  1377			 */
  1378			WRITE_ONCE(sk->sk_txrehash, (u8)val);
  1379			return 0;
  1380		case SO_PEEK_OFF:
  1381			{
  1382			int (*set_peek_off)(struct sock *sk, int val);
  1383	
  1384			set_peek_off = READ_ONCE(sock->ops)->set_peek_off;
  1385			if (set_peek_off)
  1386				ret = set_peek_off(sk, val);
  1387			else
  1388				ret = -EOPNOTSUPP;
  1389			return ret;
  1390			}
  1391	#ifdef CONFIG_PAGE_POOL
  1392		case SO_DEVMEM_DONTNEED:
  1393			return sock_devmem_dontneed(sk, optval, optlen);
  1394	
> 1395		case SO_DEVMEM_AUTORELEASE:
  1396			return sock_devmem_set_autorelease(sk, optval, optlen);
  1397	#endif
  1398		case SO_SNDTIMEO_OLD:
  1399		case SO_SNDTIMEO_NEW:
  1400			return sock_set_timeout(&sk->sk_sndtimeo, optval,
  1401						optlen, optname == SO_SNDTIMEO_OLD);
  1402		case SO_RCVTIMEO_OLD:
  1403		case SO_RCVTIMEO_NEW:
  1404			return sock_set_timeout(&sk->sk_rcvtimeo, optval,
  1405						optlen, optname == SO_RCVTIMEO_OLD);
  1406		}
  1407	
  1408		sockopt_lock_sock(sk);
  1409	
  1410		switch (optname) {
  1411		case SO_DEBUG:
  1412			if (val && !sockopt_capable(CAP_NET_ADMIN))
  1413				ret = -EACCES;
  1414			else
  1415				sock_valbool_flag(sk, SOCK_DBG, valbool);
  1416			break;
  1417		case SO_REUSEADDR:
  1418			sk->sk_reuse = (valbool ? SK_CAN_REUSE : SK_NO_REUSE);
  1419			break;
  1420		case SO_REUSEPORT:
  1421			if (valbool && !sk_is_inet(sk))
  1422				ret = -EOPNOTSUPP;
  1423			else
  1424				sk->sk_reuseport = valbool;
  1425			break;
  1426		case SO_DONTROUTE:
  1427			sock_valbool_flag(sk, SOCK_LOCALROUTE, valbool);
  1428			sk_dst_reset(sk);
  1429			break;
  1430		case SO_BROADCAST:
  1431			sock_valbool_flag(sk, SOCK_BROADCAST, valbool);
  1432			break;
  1433		case SO_SNDBUF:
  1434			/* Don't error on this BSD doesn't and if you think
  1435			 * about it this is right. Otherwise apps have to
  1436			 * play 'guess the biggest size' games. RCVBUF/SNDBUF
  1437			 * are treated in BSD as hints
  1438			 */
  1439			val = min_t(u32, val, READ_ONCE(sysctl_wmem_max));
  1440	set_sndbuf:
  1441			/* Ensure val * 2 fits into an int, to prevent max_t()
  1442			 * from treating it as a negative value.
  1443			 */
  1444			val = min_t(int, val, INT_MAX / 2);
  1445			sk->sk_userlocks |= SOCK_SNDBUF_LOCK;
  1446			WRITE_ONCE(sk->sk_sndbuf,
  1447				   max_t(int, val * 2, SOCK_MIN_SNDBUF));
  1448			/* Wake up sending tasks if we upped the value. */
  1449			sk->sk_write_space(sk);
  1450			break;
  1451	
  1452		case SO_SNDBUFFORCE:
  1453			if (!sockopt_capable(CAP_NET_ADMIN)) {
  1454				ret = -EPERM;
  1455				break;
  1456			}
  1457	
  1458			/* No negative values (to prevent underflow, as val will be
  1459			 * multiplied by 2).
  1460			 */
  1461			if (val < 0)
  1462				val = 0;
  1463			goto set_sndbuf;
  1464	
  1465		case SO_RCVBUF:
  1466			/* Don't error on this BSD doesn't and if you think
  1467			 * about it this is right. Otherwise apps have to
  1468			 * play 'guess the biggest size' games. RCVBUF/SNDBUF
  1469			 * are treated in BSD as hints
  1470			 */
  1471			__sock_set_rcvbuf(sk, min_t(u32, val, READ_ONCE(sysctl_rmem_max)));
  1472			break;
  1473	
  1474		case SO_RCVBUFFORCE:
  1475			if (!sockopt_capable(CAP_NET_ADMIN)) {
  1476				ret = -EPERM;
  1477				break;
  1478			}
  1479	
  1480			/* No negative values (to prevent underflow, as val will be
  1481			 * multiplied by 2).
  1482			 */
  1483			__sock_set_rcvbuf(sk, max(val, 0));
  1484			break;
  1485	
  1486		case SO_KEEPALIVE:
  1487			if (sk->sk_prot->keepalive)
  1488				sk->sk_prot->keepalive(sk, valbool);
  1489			sock_valbool_flag(sk, SOCK_KEEPOPEN, valbool);
  1490			break;
  1491	
  1492		case SO_OOBINLINE:
  1493			sock_valbool_flag(sk, SOCK_URGINLINE, valbool);
  1494			break;
  1495	
  1496		case SO_NO_CHECK:
  1497			sk->sk_no_check_tx = valbool;
  1498			break;
  1499	
  1500		case SO_LINGER:
  1501			if (optlen < sizeof(ling)) {
  1502				ret = -EINVAL;	/* 1003.1g */
  1503				break;
  1504			}
  1505			if (copy_from_sockptr(&ling, optval, sizeof(ling))) {
  1506				ret = -EFAULT;
  1507				break;
  1508			}
  1509			if (!ling.l_onoff) {
  1510				sock_reset_flag(sk, SOCK_LINGER);
  1511			} else {
  1512				unsigned long t_sec = ling.l_linger;
  1513	
  1514				if (t_sec >= MAX_SCHEDULE_TIMEOUT / HZ)
  1515					WRITE_ONCE(sk->sk_lingertime, MAX_SCHEDULE_TIMEOUT);
  1516				else
  1517					WRITE_ONCE(sk->sk_lingertime, t_sec * HZ);
  1518				sock_set_flag(sk, SOCK_LINGER);
  1519			}
  1520			break;
  1521	
  1522		case SO_BSDCOMPAT:
  1523			break;
  1524	
  1525		case SO_TIMESTAMP_OLD:
  1526		case SO_TIMESTAMP_NEW:
  1527		case SO_TIMESTAMPNS_OLD:
  1528		case SO_TIMESTAMPNS_NEW:
  1529			sock_set_timestamp(sk, optname, valbool);
  1530			break;
  1531	
  1532		case SO_TIMESTAMPING_NEW:
  1533		case SO_TIMESTAMPING_OLD:
  1534			if (optlen == sizeof(timestamping)) {
  1535				if (copy_from_sockptr(&timestamping, optval,
  1536						      sizeof(timestamping))) {
  1537					ret = -EFAULT;
  1538					break;
  1539				}
  1540			} else {
  1541				memset(&timestamping, 0, sizeof(timestamping));
  1542				timestamping.flags = val;
  1543			}
  1544			ret = sock_set_timestamping(sk, optname, timestamping);
  1545			break;
  1546	
  1547		case SO_RCVLOWAT:
  1548			{
  1549			int (*set_rcvlowat)(struct sock *sk, int val) = NULL;
  1550	
  1551			if (val < 0)
  1552				val = INT_MAX;
  1553			if (sock)
  1554				set_rcvlowat = READ_ONCE(sock->ops)->set_rcvlowat;
  1555			if (set_rcvlowat)
  1556				ret = set_rcvlowat(sk, val);
  1557			else
  1558				WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
  1559			break;
  1560			}
  1561		case SO_ATTACH_FILTER: {
  1562			struct sock_fprog fprog;
  1563	
  1564			ret = copy_bpf_fprog_from_user(&fprog, optval, optlen);
  1565			if (!ret)
  1566				ret = sk_attach_filter(&fprog, sk);
  1567			break;
  1568		}
  1569		case SO_ATTACH_BPF:
  1570			ret = -EINVAL;
  1571			if (optlen == sizeof(u32)) {
  1572				u32 ufd;
  1573	
  1574				ret = -EFAULT;
  1575				if (copy_from_sockptr(&ufd, optval, sizeof(ufd)))
  1576					break;
  1577	
  1578				ret = sk_attach_bpf(ufd, sk);
  1579			}
  1580			break;
  1581	
  1582		case SO_ATTACH_REUSEPORT_CBPF: {
  1583			struct sock_fprog fprog;
  1584	
  1585			ret = copy_bpf_fprog_from_user(&fprog, optval, optlen);
  1586			if (!ret)
  1587				ret = sk_reuseport_attach_filter(&fprog, sk);
  1588			break;
  1589		}
  1590		case SO_ATTACH_REUSEPORT_EBPF:
  1591			ret = -EINVAL;
  1592			if (optlen == sizeof(u32)) {
  1593				u32 ufd;
  1594	
  1595				ret = -EFAULT;
  1596				if (copy_from_sockptr(&ufd, optval, sizeof(ufd)))
  1597					break;
  1598	
  1599				ret = sk_reuseport_attach_bpf(ufd, sk);
  1600			}
  1601			break;
  1602	
  1603		case SO_DETACH_REUSEPORT_BPF:
  1604			ret = reuseport_detach_prog(sk);
  1605			break;
  1606	
  1607		case SO_DETACH_FILTER:
  1608			ret = sk_detach_filter(sk);
  1609			break;
  1610	
  1611		case SO_LOCK_FILTER:
  1612			if (sock_flag(sk, SOCK_FILTER_LOCKED) && !valbool)
  1613				ret = -EPERM;
  1614			else
  1615				sock_valbool_flag(sk, SOCK_FILTER_LOCKED, valbool);
  1616			break;
  1617	
  1618		case SO_MARK:
  1619			if (!sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
  1620			    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
  1621				ret = -EPERM;
  1622				break;
  1623			}
  1624	
  1625			__sock_set_mark(sk, val);
  1626			break;
  1627		case SO_RCVMARK:
  1628			sock_valbool_flag(sk, SOCK_RCVMARK, valbool);
  1629			break;
  1630	
  1631		case SO_RCVPRIORITY:
  1632			sock_valbool_flag(sk, SOCK_RCVPRIORITY, valbool);
  1633			break;
  1634	
  1635		case SO_RXQ_OVFL:
  1636			sock_valbool_flag(sk, SOCK_RXQ_OVFL, valbool);
  1637			break;
  1638	
  1639		case SO_WIFI_STATUS:
  1640			sock_valbool_flag(sk, SOCK_WIFI_STATUS, valbool);
  1641			break;
  1642	
  1643		case SO_NOFCS:
  1644			sock_valbool_flag(sk, SOCK_NOFCS, valbool);
  1645			break;
  1646	
  1647		case SO_SELECT_ERR_QUEUE:
  1648			sock_valbool_flag(sk, SOCK_SELECT_ERR_QUEUE, valbool);
  1649			break;
  1650	
  1651		case SO_PASSCRED:
  1652			if (sk_may_scm_recv(sk))
  1653				sk->sk_scm_credentials = valbool;
  1654			else
  1655				ret = -EOPNOTSUPP;
  1656			break;
  1657	
  1658		case SO_PASSSEC:
  1659			if (IS_ENABLED(CONFIG_SECURITY_NETWORK) && sk_may_scm_recv(sk))
  1660				sk->sk_scm_security = valbool;
  1661			else
  1662				ret = -EOPNOTSUPP;
  1663			break;
  1664	
  1665		case SO_PASSPIDFD:
  1666			if (sk_is_unix(sk))
  1667				sk->sk_scm_pidfd = valbool;
  1668			else
  1669				ret = -EOPNOTSUPP;
  1670			break;
  1671	
  1672		case SO_PASSRIGHTS:
  1673			if (sk_is_unix(sk))
  1674				sk->sk_scm_rights = valbool;
  1675			else
  1676				ret = -EOPNOTSUPP;
  1677			break;
  1678	
  1679		case SO_INCOMING_CPU:
  1680			reuseport_update_incoming_cpu(sk, val);
  1681			break;
  1682	
  1683		case SO_CNX_ADVICE:
  1684			if (val == 1)
  1685				dst_negative_advice(sk);
  1686			break;
  1687	
  1688		case SO_ZEROCOPY:
  1689			if (sk->sk_family == PF_INET || sk->sk_family == PF_INET6) {
  1690				if (!(sk_is_tcp(sk) ||
  1691				      (sk->sk_type == SOCK_DGRAM &&
  1692				       sk->sk_protocol == IPPROTO_UDP)))
  1693					ret = -EOPNOTSUPP;
  1694			} else if (sk->sk_family != PF_RDS) {
  1695				ret = -EOPNOTSUPP;
  1696			}
  1697			if (!ret) {
  1698				if (val < 0 || val > 1)
  1699					ret = -EINVAL;
  1700				else
  1701					sock_valbool_flag(sk, SOCK_ZEROCOPY, valbool);
  1702			}
  1703			break;
  1704	
  1705		case SO_TXTIME:
  1706			if (optlen != sizeof(struct sock_txtime)) {
  1707				ret = -EINVAL;
  1708				break;
  1709			} else if (copy_from_sockptr(&sk_txtime, optval,
  1710				   sizeof(struct sock_txtime))) {
  1711				ret = -EFAULT;
  1712				break;
  1713			} else if (sk_txtime.flags & ~SOF_TXTIME_FLAGS_MASK) {
  1714				ret = -EINVAL;
  1715				break;
  1716			}
  1717			/* CLOCK_MONOTONIC is only used by sch_fq, and this packet
  1718			 * scheduler has enough safe guards.
  1719			 */
  1720			if (sk_txtime.clockid != CLOCK_MONOTONIC &&
  1721			    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
  1722				ret = -EPERM;
  1723				break;
  1724			}
  1725	
  1726			ret = sockopt_validate_clockid(sk_txtime.clockid);
  1727			if (ret)
  1728				break;
  1729	
  1730			sock_valbool_flag(sk, SOCK_TXTIME, true);
  1731			sk->sk_clockid = sk_txtime.clockid;
  1732			sk->sk_txtime_deadline_mode =
  1733				!!(sk_txtime.flags & SOF_TXTIME_DEADLINE_MODE);
  1734			sk->sk_txtime_report_errors =
  1735				!!(sk_txtime.flags & SOF_TXTIME_REPORT_ERRORS);
  1736			break;
  1737	
  1738		case SO_BINDTOIFINDEX:
  1739			ret = sock_bindtoindex_locked(sk, val);
  1740			break;
  1741	
  1742		case SO_BUF_LOCK:
  1743			if (val & ~SOCK_BUF_LOCK_MASK) {
  1744				ret = -EINVAL;
  1745				break;
  1746			}
  1747			sk->sk_userlocks = val | (sk->sk_userlocks &
  1748						  ~SOCK_BUF_LOCK_MASK);
  1749			break;
  1750	
  1751		case SO_RESERVE_MEM:
  1752		{
  1753			int delta;
  1754	
  1755			if (val < 0) {
  1756				ret = -EINVAL;
  1757				break;
  1758			}
  1759	
  1760			delta = val - sk->sk_reserved_mem;
  1761			if (delta < 0)
  1762				sock_release_reserved_memory(sk, -delta);
  1763			else
  1764				ret = sock_reserve_memory(sk, delta);
  1765			break;
  1766		}
  1767	
  1768		default:
  1769			ret = -ENOPROTOOPT;
  1770			break;
  1771		}
  1772		sockopt_release_sock(sk);
  1773		return ret;
  1774	}
  1775	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

